#------------------------------------------------------------------------------
# Copyright (c) 2013 The University of Manchester, UK.
#
# BSD Licenced. See LICENCE.rdoc for details.
#
# Taverna Player was developed in the BioVeL project, funded by the European
# Commission 7th Framework Programme (FP7), through grant agreement
# number 283359.
#
# Author: Robert Haines
#------------------------------------------------------------------------------

# These methods are the default renderer callbacks that Taverna Player uses.
# If you customize (or add to) the methods in this file you must register them
# in the Taverna Player initializer. These methods will not override the
# defaults automatically.
#
# Each method MUST accept two parameters:
#  * The first (content) is what will be rendered. In the case of a text/*
#    type output this will be the actual text. In the case of anything else
#    this will be a path to the object to be linked to.
#  * The second (type) is the MIME type of the output as a string. This allows
#    a single method to handle multiple types or sub-types if needed.
#
# Note that you can use most of the ActiveView Helpers here as global methods
# but the image_tag() method does not work as explained below.

def format_text(content, type)
  # Use CodeRay to format text so that newlines are respected.
  content = CodeRay.scan(content, :text).div(:css => :class)

  # Use auto_link to turn URI-like text into links.
  auto_link(content, :html => { :target => '_blank' }, :sanitize => false)
end

def format_xml(content, type)
  # Make sure XML is indented consistently.
  out = String.new
  REXML::Document.new(content).write(out, 1)
  CodeRay.scan(out, :xml).div(:css => :class, :line_numbers => :table)
end

def show_image(content, type)
  # Can't use image_tag() here because the image doesn't really exist (it's in
  # a zip file, really) and this confuses the Rails asset pipeline.
  tag("img", :src => content)
end

def workflow_error(content, type)
  link_to("This output is a workflow error.", content)
end

def cannot_inline(content, type)
  "Sorry but we cannot show this type of content in the browser. Please " +
   link_to("download it", content) + " to view it on your local machine."
end
