class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    unless value =~ URI::DEFAULT_PARSER.make_regexp(%w[http https])
      record.errors.add(attribute, (options[:message] || "n'est pas une URL valide"))
    end
  end
end
