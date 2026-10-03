/**
 * Three.js 3D WebGL Graph Visualization Engine
 * Renders Directed Acyclic Graphs (DAG) with Critical Path halos.
 */

class Graph3DVisualizer {
  constructor(containerId, options = {}) {
    this.container = document.getElementById(containerId);
    if (!this.container) return;

    this.options = Object.assign({
      nodeRadius: 3.5,
      criticalColor: 0xef4444,
      normalColor: 0x06b6d4,
      edgeColor: 0x475569,
      criticalEdgeColor: 0xf87171,
    }, options);

    this.nodes = new Map();
    this.edges = [];
    this.raycaster = new THREE.Raycaster();
    this.mouse = new THREE.Vector2();

    this.initScene();
    this.initLights();
    this.animate = this.animate.bind(this);
    this.onWindowResize = this.onWindowResize.bind(this);
    window.addEventListener('resize', this.onWindowResize);

    requestAnimationFrame(this.animate);
  }

  initScene() {
    this.scene = new THREE.Scene();
    this.scene.fog = new THREE.FogExp2(0x090d16, 0.008);

    const width = this.container.clientWidth;
    const height = this.container.clientHeight;

    this.camera = new THREE.PerspectiveCamera(60, width / height, 0.1, 1000);
    this.camera.position.set(0, 25, 75);

    this.renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
    this.renderer.setSize(width, height);
    this.renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    this.renderer.shadowMap.enabled = true;
    this.container.appendChild(this.renderer.domElement);

    if (typeof THREE.OrbitControls !== 'undefined') {
      this.controls = new THREE.OrbitControls(this.camera, this.renderer.domElement);
      this.controls.enableDamping = true;
      this.controls.dampingFactor = 0.05;
      this.controls.maxDistance = 250;
      this.controls.minDistance = 15;
    }

    // Grid Floor
    const grid = new THREE.GridHelper(120, 30, 0x1e293b, 0x0f172a);
    grid.position.y = -20;
    this.scene.add(grid);
  }

  initLights() {
    const ambient = new THREE.AmbientLight(0xffffff, 0.6);
    this.scene.add(ambient);

    const dirLight1 = new THREE.DirectionalLight(0x38bdf8, 0.8);
    dirLight1.position.set(40, 60, 40);
    this.scene.add(dirLight1);

    const dirLight2 = new THREE.DirectionalLight(0x6366f1, 0.6);
    dirLight2.position.set(-40, -30, -30);
    this.scene.add(dirLight2);

    const pointLight = new THREE.PointLight(0xef4444, 1.2, 80);
    pointLight.position.set(0, 10, 0);
    this.scene.add(pointLight);
  }

  loadGraphData(nodesData, edgesData) {
    // Clear previous
    for (const [id, mesh] of this.nodes) {
      this.scene.remove(mesh);
    }
    this.nodes.clear();
    this.edges.forEach(e => this.scene.remove(e));
    this.edges = [];

    // Layout nodes topologically along X axis with layers
    const layerMap = new Map();
    nodesData.forEach((node, index) => {
      const layer = node.es !== undefined ? node.es : index;
      if (!layerMap.has(layer)) layerMap.set(layer, []);
      layerMap.get(layer).push(node);
    });

    const sortedLayers = Array.from(layerMap.keys()).sort((a, b) => a - b);
    const xSpacing = 22;
    const ySpacing = 16;
    const totalWidth = (sortedLayers.length - 1) * xSpacing;

    sortedLayers.forEach((layer, layerIdx) => {
      const nodesInLayer = layerMap.get(layer);
      const totalHeight = (nodesInLayer.length - 1) * ySpacing;

      nodesInLayer.forEach((node, nodeIdx) => {
        const x = layerIdx * xSpacing - totalWidth / 2;
        const y = -(nodeIdx * ySpacing - totalHeight / 2);
        const z = (Math.random() - 0.5) * 8;

        const isCrit = node.isCritical;
        const geo = new THREE.SphereGeometry(this.options.nodeRadius, 32, 32);
        const mat = new THREE.MeshStandardMaterial({
          color: isCrit ? this.options.criticalColor : this.options.normalColor,
          emissive: isCrit ? 0x991b1b : 0x083344,
          emissiveIntensity: isCrit ? 0.7 : 0.2,
          roughness: 0.25,
          metalness: 0.8,
        });

        const sphere = new THREE.Mesh(geo, mat);
        sphere.position.set(x, y, z);
        sphere.userData = node;

        // Glowing outer halo for critical path
        if (isCrit) {
          const haloGeo = new THREE.SphereGeometry(this.options.nodeRadius * 1.35, 16, 16);
          const haloMat = new THREE.MeshBasicMaterial({
            color: 0xef4444,
            wireframe: true,
            transparent: true,
            opacity: 0.4
          });
          const halo = new THREE.Mesh(haloGeo, haloMat);
          sphere.add(halo);
        }

        this.scene.add(sphere);
        this.nodes.set(node.id, sphere);
      });
    });

    // Create directed edges
    edgesData.forEach(edge => {
      const src = this.nodes.get(edge.from);
      const dst = this.nodes.get(edge.to);
      if (!src || !dst) return;

      const isCrit = edge.isCritical || (src.userData.isCritical && dst.userData.isCritical);
      const points = [src.position, dst.position];
      const curve = new THREE.LineCurve3(src.position, dst.position);
      const tubeGeo = new THREE.TubeGeometry(curve, 20, isCrit ? 0.8 : 0.4, 8, false);
      const tubeMat = new THREE.MeshStandardMaterial({
        color: isCrit ? this.options.criticalEdgeColor : this.options.edgeColor,
        emissive: isCrit ? 0xef4444 : 0x1e293b,
        emissiveIntensity: isCrit ? 0.8 : 0.1,
        roughness: 0.4
      });
      const tube = new THREE.Mesh(tubeGeo, tubeMat);
      this.scene.add(tube);
      this.edges.push(tube);
    });
  }

  onWindowResize() {
    if (!this.container) return;
    const width = this.container.clientWidth;
    const height = this.container.clientHeight;
    this.camera.aspect = width / height;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize(width, height);
  }

  animate(time) {
    requestAnimationFrame(this.animate);
    if (this.controls) this.controls.update();

    // Subtle floating rotation
    for (const [id, mesh] of this.nodes) {
      if (mesh.userData.isCritical) {
        mesh.rotation.y += 0.015;
        mesh.position.y += Math.sin(time * 0.003 + mesh.position.x) * 0.02;
      }
    }

    this.renderer.render(this.scene, this.camera);
  }
}

window.Graph3DVisualizer = Graph3DVisualizer;
