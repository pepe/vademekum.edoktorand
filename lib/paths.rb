require "fileutils"

module Paths
  attr_writer :sheets_path

  def sheets_path
    @sheets_path ||= "public/sheets"
    return id ? File.join(@sheets_path, id.to_s) : @sheets_path
  end

  def sheet_path(sheet_id)
    File.join(sheets_path, sheet_id.to_s + ".pdf")
  end

  def save_sheet(sheet_id, path)
    prepare_path
    begin
      FileUtils.cp(path, sheet_path(sheet_id))
    rescue
      return false
    end

    return true
  end

  private
  def prepare_path
    FileUtils.mkdir_p(sheets_path) unless File.exists?(sheets_path)
  end
end
