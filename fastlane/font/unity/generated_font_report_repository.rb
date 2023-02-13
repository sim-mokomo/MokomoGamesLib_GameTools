module Font
  module Unity
    class GeneratedReportRepository
      def read_reports(reports_root_path)
        report_glob = "#{reports_root_path}/**/*.txt"
        Dir.glob(File.expand_path(report_glob)).map do |report_path|
          File.open(report_path, 'r') do |file|
            JSON.parse(file.read, object_class: GeneratedFontReport)
          end
        end
      end
    end
  end
end
