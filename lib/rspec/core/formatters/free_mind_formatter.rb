require 'time'


#class String
#
#
#  def puts_close_node(_)
#    puts '</node>'
#  end
#
#  def puts_ex_gr_node(notification)
#    puts "<node TEXT='#{notification.group.description.strip}'"
#  end
#
#  def puts_passed_ex(passed)
#    puts "<node TEXT='#{passed.example.description.strip}'"
#    puts "<icon BUILTIN='button_ok'>"
#    puts "</node>"
#  end
#
#  def puts_failed_ex(failed)
#    puts "<node TEXT='#{failed.example.description.strip}'"
#    puts "<icon BUILTIN='button_cancel'>"
#    puts "</node>"
#  end
#
#  def puts_pending_ex(pending)
#    puts "<node TEXT='#{pending.example.description.strip}'"
#    puts "<icon BUILTIN='idea'>"
#    puts "</node>"
#  end
#
#  def puts_rt_note(duration, example_count, failure_count, pending_count)
#    puts "<richcontent TYPE='NOTE'><html>"
#    puts "<head>"
#    puts "</head>"
#    puts "<body>"
#    puts_test_info('test run duration' => '%.2f' % duration)
#    puts_test_info('example count' => example_count)
#    puts_test_info('failure count' => failure_count)
#    puts_test_info('pending count' => pending_count)
#    puts "</body>"
#    puts "</html>"
#    puts "</richcontent>"
#  end
#
#  def puts_test_info(hash)
#    puts "<p>"
#    puts hash.keys[0].to_s + ': ' + hash.values[0].to_s
#    puts "</p>"
#  end
#
#end

# Dumps rspec results as a JUnit XML file.
# Based on XML schema: http://windyroad.org/dl/Open%20Source/JUnit.xsd
class RSpec::Core::Formatters::FreeMindFormatter < RSpec::Core::Formatters::BaseFormatter

  attr_accessor :last_line, :count, :cases, :close_sections, :new_output

  def initialize(output)
    super(output)
    @new_output = ''
  end


  def start example_count
    new_output << "<?xml version='1.0' encoding='UTF-8' ?>\n"
    new_output << "<sections>\n"
  end
  
  def example_group_started(notification)
    super

    puts_ex_gr_node(notification)
  end

  def example_group_finished(_)
    puts_close_node(_)
  end

  # def example_started(notification)
  #   puts_example_started(notification)
  # end
  #
  # def puts_example_started(notification)
  #   output.puts "<case>"
  # end

  def example_passed(passed)
    super
    puts_example(passed)
  end

  def example_failed(failed)
    super
    puts_example(failed)
  end

  def example_pending(pending)
    super
    puts_example(pending)
  end

  def stop
    new_output << "</sections>\n"
    output.puts new_output
  end

  # def dump_summary duration, example_count, failure_count, pending_count
  #   super
  #
  #   #TODO Doesn't work:(
  #   lines = File.open(output, 'r') do |file|
  #     file.readlines
  #   end
  #   # lines.insert(2, puts_rt_note(duration, example_count, failure_count, pending_count))
  #   File.open(output, 'w') do |file|
  #     lines = lines.inject {|sum, n| sum.to_s + n.to_s}
  #     #lines.gsub!('\'', '\"')
  #     file.puts lines
  #   end
  # end

  def puts_close_node(_)
    if @cases
      new_output << "</cases>\n"
      @cases = false
    end

    new_output << "</section>\n"


    if @count > 0
      new_output << "</sections>\n"
      @count -= 1
    else
      @last_line = nil
    end


  end

  def puts_ex_gr_node(notification)
    if @cases
      new_output << "</cases>\n"
      @cases = false
    end
    if @last_line
      new_output << @last_line
      @count ? @count += 1 : @count = 1
    else
      sleep 1
    end
    if new_output.end_with?("</sections>\n<sections>\n")
      new_output.sub!(/<\/sections>\s<sections>\s$/,'')
    end
    new_output << "<section>\n"
    new_output << "<name>#{notification.description.strip}</name>\n"
    new_output << "<description></description>\n"
    new_output << "<cases>\n"
    @cases = true
    @last_line =  "<sections>\n"
  end



  def puts_example(example)


    new_output << "<case>\n"
    new_output << "<title>#{example.description.strip}</title>\n"
    new_output << "<type/>\n"
    new_output << "<priority/>\n"
    new_output << "<estimate/>\n"
    new_output << "<milestone/>\n"
    new_output << "<reference/>\n"
    new_output << "</case>\n"

    # output.puts "<node TEXT='#{example.description.strip}'>"
    # output.puts "<icon BUILTIN='button_ok'/>"
    # output.puts "</node>"
  end

  # def puts_rt_note(duration, example_count, failure_count, pending_count)
  #   output.puts "<richcontent TYPE='NOTE'><html>"
  #   output.puts "<head>"
  #   output.puts "</head>"
  #   output.puts "<body>"
  #   puts_test_info('test run duration' => '%.2f' % duration)
  #   puts_test_info('example count' => example_count)
  #   puts_test_info('failure count' => failure_count)
  #   puts_test_info('pending count' => pending_count)
  #   output.puts "</body>"
  #   output.puts "</html>"
  #   output.puts "</richcontent>"
  # end

  # def puts_test_info(hash)
  #   output.puts "<p>"
  #   output.puts hash.keys[0].to_s + ': ' + hash.values[0].to_s
  #   output.puts "</p>"
  # end

end

