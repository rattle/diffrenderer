#!/usr/bin/ruby

require 'rubygems'
require 'diffrenderer'

old_html= <<OLDHTML
<h2 class="title">Hello, we're Rattle</h2>
<p class="first">We're not your average digital agency. We don't do marketing, we don't do SEO, and we don't do flim flam. We just research and develop social web stuff that works.</p>

<p>Our expert knowledge allows us to develop the right social web applications for your business and your audience. Clients include the <a href="http://www.rattlecentral.com/case-studies/followme.html">BBC</a>, the <a href="http://www.rattlecentral.com/case-studies/talk-science.html">Science Museum</a>, <a href="http://www.rattlecentral.com/case-studies/a-randomers-guide-to-teenagers.html">Channel 4</a> and <a href="http://www.rattlecentral.com/case-studies/ghd.html">ghd</a>. We've also produced <a href="http://www.rattlecentral.com/case-studies/folksy.html">Folksy</a>, a website for designers and makers.</p>
OLDHTML

new_html= <<NEWHTML
<h2 class="title">Hello, we're Rattle</h2>
<p class="first">We're not your average digital agency. We don't do marketing, we don't do SEO, and we don't do flim flam. We just research and develop social web stuff that works.</p>

<p>Our expert knowledge allows us to develop the right social web applications for your business and your audience. Clients include the <a href="http://www.rattlecentral.com/case-studies/followme.html">BBC</a>, the <a href="http://www.rattlecentral.com/case-studies/talk-science.html">Science Museum</a>, <a href="http://www.rattlecentral.com/case-studies/a-randomers-guide-to-teenagers.html">Channel 4</a> and <a href="http://www.rattlecentral.com/case-studies/ghd.html">ghd</a>. We've also produced <a href="http://www.rattlecentral.com/case-studies/folksy.html">Folksy</a>, a website for designers and makers and we give away code too !</p>
NEWHTML


diffed = DiffRenderer.new(DiffRenderer.process_html(old_html), DiffRenderer.process_html(new_html)).to_html

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
