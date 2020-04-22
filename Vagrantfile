PACKAGES = [
  "gcc-arm-linux-gnueabihf",
  "gdb-multiarch",
  "qemu",

  # Not strictly necessary but make life easier
  "make",
  "bats",
]

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "private_network", ip: "10.0.0.10"
  config.vm.provision "shell" do |s|
    s.inline = <<-SHELL
      apt-get update
      apt-get install -y #{PACKAGES.join(" ")}
    SHELL
    s.env = {
      # Prevent dpkg-preconfigure from complaining
      DEBIAN_FRONTEND: "noninteractive",
    }
  end
end
