require "active_support/core_ext/object/blank"

namespace :tomify do
  desc "Generate Package from Bundle"
  task :package do
    root = Gem::Specification.find_by_name("tomify").gem_dir

    # Should be passed as arguments
    package = "react.js"
    package_bundle = "#{root}/lib/generators/tomify/bundle/templates/react.js"

    package_path = package.split("/")[0...-1].join("/")
    package_path = "#{pwd}/vendor/tomify" if package_path.blank?
    package_name = package.split("/")[-1]
    development = create_file "#{package_path}/development", package_name
    production = create_file "#{package_path}/production", package_name

    mkdir_p "tmp/tomify"
    bundle = "#{pwd}/tmp/tomify/bundle.js"
    cp package_bundle, bundle
    cd "tmp/tomify" do
      # Install
      packages = File.read(bundle).match(/^\/\/ (.*)$/)[1]
      sh "npm --loglevel=error install browserify #{packages}"

      # Package
      command = "node_modules/.bin/browserify"
      sh "#{command} #{bundle} > #{development}"
      sh "NODE_ENV=production #{command} #{bundle} > #{production}"
    end
    rm_rf "tmp/tomify"
  end
end

def create_file(path, name)
  file = "#{path}/#{name}"
  mkdir_p path
  touch file
  file
end
