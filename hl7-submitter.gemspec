# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: hl7-submitter 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "hl7-submitter"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Dave Sieh"]
  s.date = "2016-06-28"
  s.description = "Allows you to submit HL7 messages to a Mirth Connect server. Dumps the response to the command line."
  s.email = "dave.sieh@providigm.com"
  s.executables = ["submit_hl7.rb"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/submit_hl7.rb",
    "lib/hl7-submitter.rb",
    "lib/hl7-submitter/cmdline_options.rb",
    "spec/cmdline_options_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/j0hnds/hl7-submitter"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Submit HL7 messages to a Mirth Connect server"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<savon>, ["~> 2.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.4"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, [">= 2.0.1", "~> 2.0"])
      s.add_development_dependency(%q<simplecov>, ["~> 0"])
    else
      s.add_dependency(%q<savon>, ["~> 2.0"])
      s.add_dependency(%q<rspec>, ["~> 3.4"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, [">= 2.0.1", "~> 2.0"])
      s.add_dependency(%q<simplecov>, ["~> 0"])
    end
  else
    s.add_dependency(%q<savon>, ["~> 2.0"])
    s.add_dependency(%q<rspec>, ["~> 3.4"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, [">= 2.0.1", "~> 2.0"])
    s.add_dependency(%q<simplecov>, ["~> 0"])
  end
end
