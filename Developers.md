# Setup
The site is built using [middleman](https://middlemanapp.com/), which uses ruby.  

## Linux ruby environment install
This is how I set it up in Ubuntu 17.

```bash
apt install ruby-dev ruby ruby-bundler
```

## Installing the repo dependencies
From the repository root run the following command.
```bash
bundle install
```

# Run locally:
```bash
bundle exec middleman server
```

# Build static site:
```bash
bundle exec middleman build
```

## Build Environments
The `env/` folder in the repository root directory contains different build environment. They basically just say which url to use to link to the contact / volunteer forms.

To build in debug:
```bash
source env/debug
bundle exec middleman build
```

To build in release:
```bash
source env/release
bundle exec middleman build
```
