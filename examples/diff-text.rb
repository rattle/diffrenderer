#!/usr/bin/ruby

require 'rubygems'
require 'diffrenderer'

old_text = ['This was some text']
new_text = ['This is some text']

diffed = DiffRenderer.new(old_text, new_text).to_html

out = <<HTML
<html>
<head>
<title>DiffRenderer Example</title>

<style type="text/css">
<!--
#content {
        float: left;
        width: 560px;
        background: #FFF;
        margin-bottom: 10px;
        margin-left: 10px;
        padding: 1em 20px 0px;
}
#content p.added {
  background: #66ff66;
  margin-top: 0;
  margin-left: -0.5em;
  margin-right: -0.5em;
  padding: 0.5em;
}
#content p.removed {
  background: #ff6666;
  text-decoration: line-through;
  padding: 0.5em;
  margin-top: 0;
  margin-left: -0.5em;
  margin-right: -0.5em;
}
#content p.replaced {
  margin-top: 0;
  margin-bottom: 0;
  margin-left: -0.5em;
  margin-right: -0.5em;
}
#content span.added {
  background: #66ff66;
  padding: 2px 2px;
}
#content span.removed {
  background: #ff6666;
  padding: 2px 2px;
  text-decoration: line-through;
}
-->
</style>

</head>

<body>
<div id="content">
#{diffed}
</div>
</body>
</html>

HTML

puts out
