/* creating fact for prescriptions */

{{ config(materialized='table') }}

with hcp as (

    select * from {{ ref('STG_HCP_DTL') }}

),
trx as (

    select * from {{ source('raw_data_tables', 'raw_trx') }}

),
ptnt as (

    select * from {{ source('raw_data_tables', 'raw_ptnt') }}

)

select trx.*,
hcp_name,hcp_zip,hcp_team,hcp_territory,
PATIENT_YOB
from trx 
left outer join
hcp
on (trx.hcp_npi = hcp.hcp_npi)
left outer join
ptnt
on (trx.patient_id = ptnt.patient_id)