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



  def start example_count
    output.puts "<map version='1.0.1'>"    
  end
  
  def example_group_started(notification)
    super

    puts_ex_gr_node(notification)
  end

  def example_group_finished(_)
    puts_close_node(_)
  end

  def example_passed(passed)
    puts_passed_ex(passed)
  end

  def example_failed(failed)
    super
    puts_failed_ex(failed)
  end

  def example_pending(pending)
    super
    puts_pending_ex(pending)
  end

  def stop
    output.puts '</map>'
  end

  def dump_summary duration, example_count, failure_count, pending_count
    super

    #TODO Doesn't work:(
    lines = File.open(output, 'r') do |file|
      file.readlines
    end
    lines.insert(2, puts_rt_note(duration, example_count, failure_count, pending_count))
    File.open(output, 'w') do |file|
      lines = lines.inject {|sum, n| sum.to_s + n.to_s}
      #lines.gsub!('\'', '\"')
      file.puts lines
    end




  end

  def puts_close_node(_)
    output.puts '</node>'
  end

  def puts_ex_gr_node(notification)
    output.puts "<node TEXT='#{notification.description.strip}'>"
  end

  def puts_passed_ex(passed)
    output.puts "<node TEXT='#{passed.description.strip}'>"
    output.puts "<icon BUILTIN='button_ok'/>"
    output.puts "</node>"
  end

  def puts_failed_ex(failed)
    output.puts "<node TEXT='#{failed.description.strip}'>"
    output.puts "<icon BUILTIN='button_cancel'/>"
    output.puts "</node>"
  end

  def puts_pending_ex(pending)
    output.puts "<node TEXT='#{pending.description.strip}'>"
    output.puts "<icon BUILTIN='idea'/>"
    output.puts "</node>"
  end

  def puts_rt_note(duration, example_count, failure_count, pending_count)
    output.puts "<richcontent TYPE='NOTE'><html>"
    output.puts "<head>"
    output.puts "</head>"
    output.puts "<body>"
    puts_test_info('test run duration' => '%.2f' % duration)
    puts_test_info('example count' => example_count)
    puts_test_info('failure count' => failure_count)
    puts_test_info('pending count' => pending_count)
    output.puts "</body>"
    output.puts "</html>"
    output.puts "</richcontent>"
  end

  def puts_test_info(hash)
    output.puts "<p>"
    output.puts hash.keys[0].to_s + ': ' + hash.values[0].to_s
    output.puts "</p>"
  end

end

