require './lib/database'
require './lib/factor_weights'

class WaterSample < OpenStruct

  TRIHALOMETHANES = [:chloroform, :bromoform, :bromodichloromethane, :dibromichloromethane]

  def self.find(find_id)
    rows = db_client.query("select * from water_samples where id = #{find_id.to_i}").each(:as => :hash)
    return !rows.empty? ? new(rows.first) : nil
  end

  def factor(factor_weights_id)
    factor_weights = FactorWeights.find(factor_weights_id)
    factor_weights.nil? ? nil : TRIHALOMETHANES.inject(0) { |suma, compound| suma + (self.send(compound) * factor_weights.send("#{compound}_weight")) }
  end

  def to_hash(include_factors = false)
    ws = self.to_h
    FactorWeights.all_ids.each {|fw_id| ws["factor_#{fw_id}".to_sym] = self.factor(fw_id) } if include_factors && !FactorWeights.all_ids.empty?
    return ws
  end

private

  def self.db_client
    @db_client ||= Database.instance.client
  end

end

