# Setup
The site is built using [middleman](https://middlemanapp.com/), which uses ruby. So you will need a working ruby environment. 

```bash
gem install middleman
bundle install
```

**Running on linux?** Install `rb-inotify`. Not needed for OS X though.
```bash
gem install rb-inotify
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
