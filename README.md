# open-api-elevation
This gem is both for using official Open Elevation API https://open-elevation.com/ and the one you can serve on your own server https://github.com/Jorl17/open-elevation/blob/master/docs/host-your-own.md
I encourage you if you plan to use Open Elevation API to either host on your own (mind it requires to store a lot of data ~20GB) or donate for Open Elevation API servers to help the creator provide the service


## Instalation

The open-api-elevation gem is available at rubygems.org. You can install with:

`gem install open-api-elevation`

Alternatively, you can install the gem with bundler:

## Gemfile

`gem 'open-api-elevation'`

After doing bundle install, you should have the gem installed in your bundle.


## Configuration
If you want to use public OpenElevation API you may omit this step

```
OpenElevation.configure do |config|
  config.api_url = 'https://EXAMPLE_API_SERVER/api/v1/lookup'
end
```

## Usage

You need to prepare collection that reponds to longitude and latitude methods
```
service = described_class.new(collection: ...)
service.call
```

Results then may be obtained by
```
service.raw_response # as Hash
service.collection_with_result # as original collection with elevation filled (if possible) 
```


## Development

Building gem locally (you can change file name, ofc):

`gem build *.gemspec -o pkg/open-api-elevation.gem`

Installing:
`gem install pkg/open-api-elevation.gem`


