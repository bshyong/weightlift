desc "Tasks to be called by Heroku scheduler"

task :eliminate_duplicate_lift_names => :environment do
  # find unique lift names
  unique_names = Lift.all.pluck(:name).map(&:downcase).uniq
  unique_names.each do |n|
    # store all reps with same lift names
    reps = []
    # identify lift name with most reps
    Lift.where('LOWER(name) = ?', n).each do |l|
      reps << l.reps
      lr ||= l
      lr = (lr.reps.count > l.reps.count ? lr : l)
    end
    lr.reps << reps
  end
end