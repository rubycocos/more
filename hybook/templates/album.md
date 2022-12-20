
## {{ album.title }}

{% album.sections.each do |section| %}

#### {{ section.title }} _({{ section.pictures.size }})_{: .count}

  {{ render_pictures( section.pictures, opts ) }}

{% end %}
