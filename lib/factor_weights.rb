require './lib/database'

class FactorWeights < OpenStruct

  def self.find(find_id)
    rows = db_client.query("select * from factor_weights where id = #{find_id.to_i}").each(:as => :hash)
    return !rows.empty? ? new(rows.first) : nil
  end

  def self.all_ids
    rows = db_client.query("select id from factor_weights").each(:as => :array)
    return !rows.empty? ? rows.flatten : []
  end

private

  def self.db_client
    @db_client ||= Database.instance.client
  end

end