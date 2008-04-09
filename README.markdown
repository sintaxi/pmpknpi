# PmpknPi

[PmpknPi](http://pmpknpi.com) is a Merb blog system.

### Features
  
  - Image uploading(& thumbnailing) via attachment_fu
  - Write articles in Textile, Markdown, or HTML
  - Users may vote on comments (no registration required)
  - completely UJS using JQuery
  - RESTful architecture

### Dependencies

  - merb 0.9.2
  - active_record
  - merb_activerecord
  - BlueCloth
  - RedCloth
  - CodeRay
  - merb\_can\_filter
  
### Get Started - clone/cofigure/migrate
    
    git clone git://github.com/sintaxi/pmpknpi.git
    cd pmpknpi
    cp config/database.sample.yml config/database.yml
    rake db:migrate
    merb
    
    *set your preferences in config/settings.yml

## The MIT License  

Copyright (c) 2008 Brock Whitten

Permission is hereby granted, free of charge, to any person obtaining  
a copy of this software and associated documentation files (the  
"Software"), to deal in the Software without restriction, including  
without limitation the rights to use, copy, modify, merge, publish,  
distribute, sublicense, and/or sell copies of the Software, and to  
permit persons to whom the Software is furnished to do so, subject to  
the following conditions:  

The above copyright notice and this permission notice shall be  
included in all copies or substantial portions of the Software.  

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,  
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF  
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND  
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE  
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION  
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION  
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  

