#encoding: utf-8
require 'active_support/inflector'
require 'tempfile'
require 'prawn'

module Renderer
  module Questionnaire
    class PDF
      attr_reader :title, :params, :questions

      def initialize(title = "", params = {}, questions = [])
        @title = title
        @params = params
        @questions = questions
      end

      def questions_with_answers
        @questions.map do |question|
          text = question.first
          if question[1] != "section"
            [text, params[text.parameterize]]
          else
            [' ', text]
          end
        end
      end

      def prepare_file
        f = Tempfile.new("questionnaire.pdf", encoding: "ascii-8bit")
        f.write render
        f.flush
        f.close
        return f.path
      end

      private
      def render
        pdf = Prawn::Document.new
        pdf.font_families.update("Calibri" => {
                             normal: File.join(File.dirname(__FILE__), 'fonts', "Calibri.ttf"),
                             bold: File.join(File.dirname(__FILE__), 'fonts', "Calibri-Bold.ttf") } )
        pdf.font 'Calibri'
        pdf.text title, size: 24
        pdf.draw_text I18n::l(Date.today, format: :long), at: [450, 720]
        questions_with_answers.each do |pair|
          pdf.text pair.first, style: :bold
          if pair.last && !pair.last.empty?
            pdf.text pair.last
          else
            pdf.text I18n::t(:not_answered)
          end
          pdf.move_down 16
        end
        pdf.render
      end
    end
  end
end


