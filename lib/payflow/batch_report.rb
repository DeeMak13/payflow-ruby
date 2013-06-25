module Payflow
  class BatchReport < Report
    def create_report(processor)
      xml = Builder::XmlMarkup.new
      xml.tag! 'runReportRequest' do
        xml.tag! 'reportName', 'BatchReport'

        [
          {name: 'processor', value: processor},
          {name: 'start_date', value: '2013-05-03'},
          {name: 'end_date', value: '2013-06-03'}
        ].each do |param|
          xml.tag! 'reportParam' do
            xml.tag! 'paramName', param[:name]
            xml.tag! 'paramValue', param[:value]
          end
        end
      end

      response = commit(xml.target!)
      @report_id = response.report_id if response.successful?
      response
    end
  end
  end
end