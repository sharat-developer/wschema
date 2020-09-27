Workato schema gem. Formats Workato schema to remove the defaults and sanitize the object_definition fields. Find the [wschema](https://rubygems.org/gems/wschema) gem on the [RubyGems.org](https://rubygems.org)!

Installation
------------
 $`gem install wschema`


Usage
------------
```
require 'wschema'

Wschema.format_schema("[{\"name\":\"name\",\"control_type\": \"text\",\"label\": \"Name\"}]")
```



```
$irb

>> require 'wschema'
=> true

>> Wschema.format_schema("[{\"name\":\"name\",\"control_type\": \"text\",\"label\": \"Name\"}]")
=> {:formatted_schema=>"[{\"name\":\"name\"}]"}
```
