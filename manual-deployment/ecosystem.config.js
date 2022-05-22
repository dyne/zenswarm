module.exports = {
  deploy: {
    production: {
      path: "/root/zenswarm/",
      host: ["vmlets"],
      ref : "origin/main",
      repo: "https://github.com/dyne/zenswarm.git",
      "post-setup": "ls -la",
      "post-deploy": "cd /root/zenswarm && bash manual-deployment/instance-provisioning.sh && pm2 startOrGracefulReload ecosystem.config.js --env production"
    }
  }
}
