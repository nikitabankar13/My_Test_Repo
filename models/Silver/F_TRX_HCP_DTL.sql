/* creating fact for prescriptions */

{{ config(materialized='table') }}

with hcp as (

    select * from {{ ref('STG_HCP_DTL') }}

),
trx as (

    select * from RAW.DRUG_SALES.LDG_TRX_DTL

),
ptnt as (

    select * from RAW.DRUG_SALES.LDG_PTNT_DETAIL

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