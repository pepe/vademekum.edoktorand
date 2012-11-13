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
          [text, params[text.parameterize]]
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
        questions_with_answers.each do |pair|
          next unless pair.last
          pdf.text pair.first, style: :bold
          pdf.text pair.last
          pdf.move_down 16
        end
        logo_img = File.join(File.dirname(__FILE__), 'images', "logo.jpg")
        pdf.image logo_img, :at => [450, 740], :width => 100
        pdf.render
      end
    end
  end
end

