class BadgeCreator
  attr_reader :device_id

  def initialize(device_id)
    @device_id = device_id
  end

  AVAILABLE_BUDGES = [
    {
      value: -> (device_id) { Event.where(event_type: :button, device_id: device_id).count },
      badges: [
        {
          condition: -> (value) { value > 0 },
          name: :one_click,
          description: 'You clicked once! Good job'
        },
        {
          condition: -> (value) { value >= 5 },
          name: :five_clicks,
          description: '5 Clickety clicks! wow'
        },
        {
          condition: -> (value) { value >= 100 },
          name: :hundred_clicks,
          description: 'The shit is getting serious'
        }
      ]
    },
    {
      value: -> (device_id) { Event.where(event_type: :button, device_id: device_id).order(duration: :desc).first&.duration.to_f },
      badges: [
        {
          condition: -> (value) { value < 0.1 },
          name: :fast_one,
          description: 'Impressively fast clicks'
        },
        {
          condition: -> (value) { value > 5 },
          name: :long_one,
          description: "You held that really long, didn't you want to pee or something?"
        }
      ]
    }
  ]

  def calculate_badges
    AVAILABLE_BUDGES.each do |value:, badges:|
      v = value.call(device_id)
      badges.each do |condition:, name:, description:|
        if condition.call(v) && Badge.where(device_id: device_id, badge: name).exists? == false
          begin
            Badge.create(device_id: device_id, badge: name, description: description)
          rescue ActiveRecord::RecordNotUnique
          end
        end
      end
    end
  end
end
