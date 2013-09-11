This document is editing now.

# Packer::Server

This is a tool to use [Packer](http://www.packer.io) on the remote server.
This starts to build image(s) when this get http request.

The build process is below.

1. Checkout from repository.
2. Run `packer build` command.

## Build Status

[![Build Status](https://travis-ci.org/Kuchitama/packer-server.png)](https://travis-ci.org/Kuchitama/packer-server)

## Requrement

### Ruby

* 1.9.3
* 2.0.0

### Packer

You need install [Packer](http://www.packer.io) before use this tool.

[Packer|iInstallaion](http://www.packer.io/docs/installation.html)

### VCS

paker-serve support git only now.

* Git


## Installation

Add this line to your application's Gemfile:

    gem 'packer-server'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install packer-server

## Usage

### 1. Create Packer configuration


### 2. Create packer-server configuration
 
### 3. Run command

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
