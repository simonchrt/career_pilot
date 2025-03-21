module ApplicationsHelper
  def status_badge(status)
    case status.to_s
    when 'bookmarked'
      'bg-purple-100 text-purple-800'
    when 'applying'
      'bg-gray-100 text-gray-800'
    when 'applied'
      'bg-blue-100 text-blue-800'
    when 'screening'
      'bg-yellow-100 text-yellow-800'
    when 'interviewing'
      'bg-yellow-100 text-yellow-800'
    when 'offer'
      'bg-green-100 text-green-800'
    when 'rejected'
      'bg-red-100 text-red-800'
    when 'accepted'
      'bg-indigo-100 text-indigo-800'
    when 'withdrawn'
      'bg-gray-100 text-gray-800'
    else
      'bg-gray-100 text-gray-800'
    end
  end

  def status_text(status)
    t("application.statuses.#{status}", default: status.to_s.humanize)
  end
end
