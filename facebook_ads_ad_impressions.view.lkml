explore: facebook_ads_ad_impressions {
  persist_with: facebook_ads_etl_datagroup
  hidden: yes
  from: facebook_ads_ad_impressions
  view_name: fact
}

view: facebook_ads_ad_impressions {
  extends: [ad_metrics_base, date_base, period_base, date_primary_key_base, pdt_base]

  derived_table: {
    datagroup_trigger: facebook_ads_etl_datagroup
    explore_source: fb_ad_impressions_platform_and_device {
      column: _date { field: fact.date_date}
      column: channel { field: fact.publisher_platform }
      column: account_id { field: fact.account_id }
      column: account_name { field: fact.account_name }
      column: campaign_id { field: fact.campaign_id }
      column: campaign_name { field: fact.campaign_name }
      column: ad_group_id { field: fact.adset_id }
      column: ad_group_name { field: fact.adset_name }
      column: cost { field: fact.total_cost }
      column: impressions { field: fact.total_impressions }
      column: clicks { field: fact.total_clicks }
      column: conversions { field: fact.total_conversions }
      column: _distribution_alias {field: fact.date_raw }
      column: _sortkey_alias {field: fact.date_raw }
    }
  }

  dimension: _date {
    hidden: yes
    type: date_raw
  }
  dimension: channel {}
  dimension: account_id {
    hidden: yes
  }
  dimension: campaign_id {
    hidden: yes
  }
  dimension: ad_group_id {
    hidden: yes
  }
  dimension: account_name {}
  dimension: campaign_name {}
  dimension: ad_group_name {}
  dimension: cross_channel_ad_group_key_base {
    hidden: yes
    sql: concat(${channel}, ${account_id}, ${campaign_id}, ${ad_group_id}) ;;
  }
  dimension: key_base {
    hidden: yes
    sql: ${cross_channel_ad_group_key_base} ;;
  }
}
