require 'active_support/inflector'

module Renderer
  module Questionnaire
    def question(qa)
      quest = qa[0]
      type = case qa[1]
             when 'check'
               'checkbox'
             when 'write'
               'text'
             when 'choose'
               'radio'
             end
      name  = qa[0].parameterize
      res = "<p>#{quest}</p>"
      Array(qa[2]).each do |value|
        res.concat "<label>#{value}" unless type == "text"
        res.concat "<input type='#{type}' name='#{name}' value='#{value}'/>"
        res.concat "</label>" unless type == "text"
      end

      return res
    end
  end
end
