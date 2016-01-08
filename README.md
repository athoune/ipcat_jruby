IPcat, for Ruby
===============

[IPcat](https://github.com/client9/ipcat) provides blocks of IP,
that correspond to datacenters, co-location centers, shared and virtual
webhosting providers.

You have to fetch the CSV file (GPL licensed) from the original website.

Usage
-----

```ruby
require 'ipcat'

datacenters = IPCat::Datacenters.new('datacenters.csv')

p datacenters.find('54.186.104.15') # rubygems.org
```

License
-------

MIT
