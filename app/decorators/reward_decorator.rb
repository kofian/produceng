class RewardDecorator < Draper::Decorator
  decorates :reward
  include Draper::LazyHelpers
  include AutoHtml

  def display_deliver_estimate
    I18n.l(source.deliver_at, format: :estimate)
  rescue
    source.deliver_at
  end

  def display_remaining
    I18n.t('rewards.index.display_remaining', remaining: source.remaining, maximum: source.maximum_contributions)
  end

  def name
    deliver = %{
        <div class="fontsize-smallest fontcolor-secondary">
          Delivery estimate:&nbsp;#{source.display_deliver_estimate || I18n.t('projects.contributions.no_estimate')}
        </div>
    }
    %{
      <label data-minimum-value="#{source.minimum_value > 0 ? source.minimum_value.to_f : '1'}" class="w-form-label fontsize-large fontweight-semibold" for="contribution_reward#{source.id && "_#{source.id}"}">
        #{source.minimum_value > 0 ? source.display_minimum+' ' : I18n.t('rewards.index.dont_want')}
      </label>
      <div class="w-row">
        <div class="w-col w-col-10 w-sub-col">
          <p class="fontsize-small u-margintop-20">
          #{html_escape(source.description)}
          </p>
          <div class="fontsize-smallest fontcolor-secondary">
            #{source.id ? deliver : ''}
          </div>
        </div>
        <div class="w-col w-col-2 input number required">
          <label class="field-label">
            qty
          </label>
          <input id="produce_qty_#{source.id}" name="produce_qty" class="w-input text-field positive required produce-qty" required="required" type="number" min="1" #{source.maximum_contributions.to_i > 0 ? "max='#{source.maximum_contributions.to_i}'" : "" } value ="1"/>
          <div class="fontsize-smaller text-error u-marginbottom-20 fa fa-exclamation-triangle w-hidden" data-error-for="produce_qty">Please enter how many pieces do you want.</div>
        </div>
      </div>
      <span class="badge badge-success fontsize-smaller">#{I18n.t('projects.contributions.you_selected')}</span>
    }.html_safe
  end

  def display_minimum
    number_to_currency source.minimum_value,precision: 2
  end

  def short_description
    truncate source.description, length: 35
  end

  def medium_description
    truncate source.description, length: 65
  end

  def last_description
    if source.versions.present?
      reward = source.versions.last.reify(has_one: true)
      auto_html(reward.description) { simple_format; link(target: '_blank') }
    end
  end

  def display_description
    auto_html(source.description){ html_escape; simple_format; link(target: '_blank', class: 'alt-link') }
  end
end
