class Questionnaire < Document
  before_save :sanitize_body

  def questions
    body.split("???").select(&:present?).map do |question|
      fields = question.split("\n\n")
      text = fields[0].strip
      case fields[1][0..2]
      when 'xxx'
        type = 'check'
        options = fields[1].split("\n")[1..-1]
      when 'ooo'
        type = 'choose'
        options = fields[1].split("\n")[1..-1]
      when '___'
        type = 'write'
        options = fields[1][4..-1]
      end
      [text, type, options]
    end
  end

  private
  def sanitize_body
    body.gsub!(/\r\n/, "\n")
  end
end
