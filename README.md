# Packer::Remote

This is a tool to use [Packer](http://www.packer.io) on the remote server.
This starts to build image(s) when this get http request.

The build process is below.

1. Checkout from repository.
2. Run `packer build` command.

## Build Status

[![Build Status](https://travis-ci.org/Kuchitama/packer-remote.png)](https://travis-ci.org/Kuchitama/packer-remote)

## Requrement

### Ruby

* 1.9.3
* 2.0.0

### Packer

You need install [Packer](http://www.packer.io) before use this tool.

[Packer|iInstallaion](http://www.packer.io/docs/installation.html)

### VCS

paker-remote support git only now.

* Git


## Installation

1. Download gem file from [here](https://drive.google.com/folderview?id=0B-273DBGeDw7UnhsWGFDSkZZSHM&usp=sharing).

2. Install it yourself as:

    $ gem install packer-remote.1.0.0.gem

## Usage

### 1. Create Packer configuration

```
$ mkdir packer-sample
$ vi packer.json
```

A configuration sample is below.

```packer.json
{
  "builders": [{
    "type": "amazon-ebs",
    "region": "us-west-2",
    "source_ami": "ami-de0d9eb7",
    "instance_type": "t1.micro",
    "ssh_username": "ec2-user",
    "ssh_timeout": "5m",
    "ami_name": "Packer-{{timestamp}}",
    "access_key": "YOUR_ACCESS_KEY",
    "secret_key": "YOUR_SECRET_KEY"
  }],
  "provisioners": [{
    "type": "shell",
    "inline": ["sudo yum install -y nginx"]
  }]
}
```

### 2. Push your configuration to git

```
$ git init
$ git add .
$ git commit -am "create packer-remote repository"
$ git push -u "YOUR_REPOSITORY_URI"
```

### 3. Create packer-remote configuration

```
$ vi config.json
```

```config.json
{
   "port": 8080,
   "vcs" : {
     "url" : "_git_repository_url_",
     "type": "git"
   },
   "packer": {
     "path" : "./packer.json"
   }
}
```

**Config settings**

| Fields | Require | Type | Value                              |
|--------|:-------:|------|------------------------------------|
| port   | No      | Int  | server port number. Default = 8080 |
| vcs    | True    | Map  | vcs settinds. Detail is below.     |
| packer | No      | Map  | packer settinds. Detail is below.  |



**VCS Settings**

| Fields | Require | Type   | Value                              |
|--------|:-------:|--------|------------------------------------|
| type   | True    | String | VCS type name.                     |
| url    | True    | String | VCS repository url.                |

**Packer Settings**

| Fields | Require | Type   | Value                                                  |
|--------|:-------:|--------|--------------------------------------------------------|
| path   | No      | String | The path of packer settings. Defailt = "./packer.json" |

### 4. Run command

Execute `packer-remote run` to start a server.

```
$ packer-remote run
```

### 5. Access to your server

```
$ curl http://localhost:8080/build
```

#### Extra

If you use AWS EC2 and ELB, you can use `/health` as helth check url.
PackerRemote returns status 200 when it is running.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
