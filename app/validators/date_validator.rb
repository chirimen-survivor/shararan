class DateValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    record.errors[:attribute] << I18n.t('errors.messages.invalid_date_format') unless /\A\d{1,4}\-\d{1,2}\-\d{1,2}\Z/ =~ value

    begin
      (y,m,d) = value.split('-')
      Time.local(y, m, d, 0, 0, 0)
    rescue
      record.errors[:attribute] << I18n.t('errors.messages.invalid_date')
    end
  end

end
