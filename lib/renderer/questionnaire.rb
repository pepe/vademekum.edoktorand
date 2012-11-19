require 'active_support/inflector'

module Renderer
  module Questionnaire
    def question(qa)
      quest = qa[0]
      if qa[1] == "section"
        res = "<h4>#{quest}</h4>"
      else
        type = case qa[1]
               when 'check'
                 'checkbox'
               when 'write'
                 'text'
               when 'choose'
                 'radio'
               end
        name  = qa[0].parameterize
        res = "<p class='question'>#{quest}</p>"
        Array(qa[2]).each do |value|
          if type == "text"
            res.concat "<textarea class='answer' placeholder='#{value}' name='#{name}'></textarea>"
          else
            res.concat "<div class='answer'>"
            res.concat "<label>"
            res.concat "<input type='#{type}' name='#{name}' value='#{value}'/>"
            res.concat "&nbsp;#{value}</label>"
            res.concat "</div>"
          end
        end
      end

      return res
    end
  end
end
