SELECT
    icu.stay_id,
    icu.subject_id,
    icu.hadm_id,
    icu.intime,
    icu.outtime,
    ROUND(icu.los::numeric, 2) AS icu_los_days,

    adm.admittime,
    adm.dischtime,
    ROUND(EXTRACT(EPOCH FROM (adm.dischtime - adm.admittime)) / 86400, 2) AS hosp_los_days,

    pat.gender,
    pat.dod,
    age.age,

    COALESCE(sepsis.sepsis3, FALSE) AS sepsis_label,
    sepsis.sofa_score,
    sepsis.sofa_time,

    vent.starttime AS ventilation_starttime,
    vent.endtime AS ventilation_endtime,
    ROUND(EXTRACT(EPOCH FROM (vent.endtime - vent.starttime)) / 86400, 2) AS ventilation_days,

    hght.height AS first_day_height_cm,
    wght.weight AS first_day_weight_kg,
    CASE 
        WHEN hght.height IS NOT NULL AND wght.weight IS NOT NULL AND hght.height > 0 THEN 
            ROUND(
                (wght.weight::numeric / POWER(hght.height::numeric / 100.0, 2))::numeric,
                2
            )
        ELSE NULL
    END AS bmi,

    c.charlson_comorbidity_index,
    c.age_score,
    c.myocardial_infarct,
    c.congestive_heart_failure,
    c.peripheral_vascular_disease,
    c.cerebrovascular_disease,
    c.dementia,
    c.chronic_pulmonary_disease,
    c.rheumatic_disease,
    c.peptic_ulcer_disease,
    c.mild_liver_disease,
    c.diabetes_without_cc,
    c.diabetes_with_cc,
    c.paraplegia,
    c.renal_disease,
    c.malignant_cancer,
    c.severe_liver_disease,
    c.metastatic_solid_tumor,
    c.aids

FROM mimiciv_icu.icustays icu
INNER JOIN mimiciv_hosp.admissions adm
    ON icu.hadm_id = adm.hadm_id
INNER JOIN mimiciv_hosp.patients pat
    ON icu.subject_id = pat.subject_id
INNER JOIN mimiciv_derived.age age
    ON adm.hadm_id = age.hadm_id
LEFT JOIN mimiciv_derived.sepsis3 sepsis
    ON icu.stay_id = sepsis.stay_id
LEFT JOIN mimiciv_derived.ventilation vent
    ON icu.stay_id = vent.stay_id
LEFT JOIN mimiciv_derived.first_day_height hght
    ON icu.stay_id = hght.stay_id
LEFT JOIN mimiciv_derived.first_day_weight wght
    ON icu.stay_id = wght.stay_id
LEFT JOIN mimiciv_derived.charlson c
    ON icu.subject_id = c.subject_id
    AND icu.hadm_id = c.hadm_id

WHERE age.age >= 18
  AND icu.los >= 0.5