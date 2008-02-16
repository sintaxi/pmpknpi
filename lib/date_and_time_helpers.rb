module Merb
  module Helpers
    module RailsDateAndTime
      
      def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false)
        from_time = from_time.to_time if from_time.respond_to?(:to_time)
        to_time = to_time.to_time if to_time.respond_to?(:to_time)
        distance_in_minutes = (((to_time - from_time).abs)/60).round
        distance_in_seconds = ((to_time - from_time).abs).round
        case distance_in_minutes
          when 0..1
            return (distance_in_minutes == 0) ? 'less than a minute' : '1 minute' unless include_seconds
            case distance_in_seconds
              when 0..4   then 'less than 5 seconds'
              when 5..9   then 'less than 10 seconds'
              when 10..19 then 'less than 20 seconds'
              when 20..39 then 'half a minute'
              when 40..59 then 'less than a minute'
              else             '1 minute'
            end
          when 2..44           then "#{distance_in_minutes} minutes"
          when 45..89          then 'about 1 hour'
          when 90..1439        then "about #{(distance_in_minutes.to_f / 60.0).round} hours"
          when 1440..2879      then '1 day'
          when 2880..43199     then "#{(distance_in_minutes / 1440).round} days"
          when 43200..86399    then 'about 1 month'
          when 86400..525599   then "#{(distance_in_minutes / 43200).round} months"
          when 525600..1051199 then 'about 1 year'
          else                      "over #{(distance_in_minutes / 525600).round} years"
        end
      end

      def time_ago_in_words(from_time, include_seconds = false)
        distance_of_time_in_words(from_time, Time.now, include_seconds)
      end
      
      # Form helpers
      
      def date_control(col, attrs = {})
        date_or_time_select(col, attrs.merge(:discard_hour => true))
      end

      def datetime_control(col, attrs = {})
        date_or_time_select(col, attrs)
      end


      def select_second(datetime, options = {})
        val = datetime ? (datetime.kind_of?(Fixnum) ? datetime : datetime.sec) : ''
        if options[:use_hidden]
          options[:include_seconds] ? hidden_html(options[:field_name] || 'second', val, options) : ''
        else
          second_options = []
          0.upto(59) do |second|
            second_options << ((val == second) ?
              %(<option value="#{leading_zero_on_single_digits(second)}" selected="selected">#{leading_zero_on_single_digits(second)}</option>\n) :
              %(<option value="#{leading_zero_on_single_digits(second)}">#{leading_zero_on_single_digits(second)}</option>\n)
            )
          end
          select_html(options[:field_name] || 'second', second_options, options)
        end
      end

      def select_minute(datetime, options = {})
        val = datetime ? (datetime.kind_of?(Fixnum) ? datetime : datetime.min) : ''
        if options[:use_hidden]
          hidden_html(options[:field_name] || 'minute', val, options)
        else
          minute_options = []
          0.step(59, options[:minute_step] || 1) do |minute|
            minute_options << ((val == minute) ?
              %(<option value="#{leading_zero_on_single_digits(minute)}" selected="selected">#{leading_zero_on_single_digits(minute)}</option>\n) :
              %(<option value="#{leading_zero_on_single_digits(minute)}">#{leading_zero_on_single_digits(minute)}</option>\n)
            )
          end
          select_html(options[:field_name] || 'minute', minute_options, options)
         end
      end

      def select_hour(datetime, options = {})
        val = datetime ? (datetime.kind_of?(Fixnum) ? datetime : datetime.hour) : ''
        if options[:use_hidden]
          hidden_html(options[:field_name] || 'hour', val, options)
        else
          hour_options = []
          0.upto(23) do |hour|
            hour_options << ((val == hour) ?
              %(<option value="#{leading_zero_on_single_digits(hour)}" selected="selected">#{leading_zero_on_single_digits(hour)}</option>\n) :
              %(<option value="#{leading_zero_on_single_digits(hour)}">#{leading_zero_on_single_digits(hour)}</option>\n)
            )
          end
          select_html(options[:field_name] || 'hour', hour_options, options)
        end
      end

      def select_day(date, options = {})
        val = date ? (date.kind_of?(Fixnum) ? date : date.day) : ''
        if options[:use_hidden]
          hidden_html(options[:field_name] || 'day', val, options)
        else
          day_options = []
          1.upto(31) do |day|
            day_options << ((val == day) ?
              %(<option value="#{day}" selected="selected">#{day}</option>\n) :
              %(<option value="#{day}">#{day}</option>\n)
            )
          end
          select_html(options[:field_name] || 'day', day_options, options)
        end
      end

      def select_month(date, options = {})
        val = date ? (date.kind_of?(Fixnum) ? date : date.month) : ''
        if options[:use_hidden]
          hidden_html(options[:field_name] || 'month', val, options)
        else
          month_options = []
          month_names = options[:use_month_names] || (options[:use_short_month] ? Date::ABBR_MONTHNAMES : Date::MONTHNAMES)
          month_names.unshift(nil) if month_names.size < 13
          1.upto(12) do |month_number|
            month_name = if options[:use_month_numbers]
              month_number
            elsif options[:add_month_numbers]
              month_number.to_s + ' - ' + month_names[month_number]
            else
              month_names[month_number]
            end

            month_options << ((val == month_number) ?
              %(<option value="#{month_number}" selected="selected">#{month_name}</option>\n) :
              %(<option value="#{month_number}">#{month_name}</option>\n)
            )
          end
          select_html(options[:field_name] || 'month', month_options, options)
        end
      end

      def select_year(date, options = {})
        val = date ? (date.kind_of?(Fixnum) ? date : date.year) : ''
        if options[:use_hidden]
          hidden_html(options[:field_name] || 'year', val, options)
        else
          year_options = []
          y = date ? (date.kind_of?(Fixnum) ? (y = (date == 0) ? Date.today.year : date) : date.year) : Date.today.year

          start_year, end_year = (options[:start_year] || y-5), (options[:end_year] || y+5)
          step_val = start_year < end_year ? 1 : -1
          start_year.step(end_year, step_val) do |year|
            year_options << ((val == year) ?
              %(<option value="#{year}" selected="selected">#{year}</option>\n) :
              %(<option value="#{year}">#{year}</option>\n)
            )
          end
          select_html(options[:field_name] || 'year', year_options, options)
        end
      end

      def select_html(type, html_options, attrs)
        name_and_id_from_options(attrs, type)
        select_html  = %(<select id="#{attrs[:id]}" name="#{attrs[:name]}")
        select_html << %( disabled="disabled") if attrs[:disabled]
        select_html << %(>\n)
        select_html << %(<option value=""></option>\n) if attrs[:include_blank]
        select_html << html_options.to_s
        select_html << "</select>\n"
      end

      private

      def date_or_time_select(col, attrs = {})
        defaults = { :discard_type => true }
        attrs    = defaults.merge(attrs)
        datetime = @_obj.send(col)
        datetime ||= Time.now
        position = { :year => 1, :month => 2, :day => 3, :hour => 4, :minute => 5, :second => 6 }
        order = (attrs[:order] ||= [:year, :month, :day])

        # Discard explicit and implicit by not being included in the :order
        discard = {}
        discard[:year]   = true if attrs[:discard_year] or !order.include?(:year)
        discard[:month]  = true if attrs[:discard_month] or !order.include?(:month)
        discard[:day]    = true if attrs[:discard_day] or discard[:month] or !order.include?(:day)
        discard[:hour]   = true if attrs[:discard_hour]
        discard[:minute] = true if attrs[:discard_minute] or discard[:hour]
        discard[:second] = true unless attrs[:include_seconds] && !discard[:minute]

        # If the day is hidden and the month is visible, the day should be
        # (otherwise it could be 31 and february wouldn't be a valid date)
        if datetime && discard[:day] && !discard[:month]
          datetime = datetime.change(:day => 1)
        end

        # Maintain valid dates by including hidden fields for discarded elements
        [:day, :month, :year].each { |o| order.unshift(o) unless order.include?(o) }

        # Ensure proper ordering of :hour, :minute and :second
        [:hour, :minute, :second].each { |o| order.delete(o); order.push(o) }

        date_or_time_select = ''

        order.reverse.each do |param|
          next if discard[param] && date_or_time_select.empty?

          date_or_time_select.insert(0, self.send("select_#{param}", datetime, options_with_prefix(col, position[param], attrs.merge(:use_hidden => discard[param]))))
          date_or_time_select.insert(0,
            case param
              when :hour then (discard[:year] && discard[:day] ? "" : " &mdash; ")
              when :minute then " : "
              when :second then attrs[:include_seconds] ? " : " : ""
              else ""
            end)

        end

        date_or_time_select
      end

      def options_with_prefix(col, position, attrs)
        prefix = "#{@_object_name}"
        attrs.merge(:prefix => "#{prefix}[#{col}(#{position}i)]")
      end

      def hidden_html(type, value, options)
        name_and_id_from_options(options, type)
        hidden_html = %(<input type="hidden" id="#{options[:id]}" name="#{options[:name]}" value="#{value}" />\n)
      end

      def name_and_id_from_options(attrs, type)
        attrs[:name] = (attrs[:prefix] || DEFAULT_PREFIX) + (attrs[:discard_type] ? '' : "[#{type}]")
        attrs[:id] = attrs[:name].gsub(/([\[\(])|(\]\[)/, '_').gsub(/[\]\)]/, '')
      end

      def leading_zero_on_single_digits(number)
        number > 9 ? number : "0#{number}"
      end
    end
  end
end