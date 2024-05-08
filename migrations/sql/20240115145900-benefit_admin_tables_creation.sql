/*
CREATING ENUM TYPES
*/

create type benefits.enum_benefit_dependents_beneficiary_type as enum ('PRIMARY', 'CONTINGENT');

create type benefits.enum_benefit_dependents_dependent_type as enum ('DEPENDENT', 'BENEFICIARY');

create type benefits.enum_benefit_dependents_gender as enum ('FEMALE', 'MALE');

create type benefits.enum_benefit_dependents_relation_type as enum ('SPOUSE', 'CHILD');

create type benefits.enum_benefit_provider_plan_billing_rules_billing_frequency as enum ('MONTHLY', 'BIWEEKLY', 'BIMONTHLY');

create type benefits.enum_benefit_provider_plan_billing_rules_coverage_beneficiar as enum ('EMPLOYEE', 'ADULT_DEPENDENT', 'MINOR_DEPENDENT');

create type benefits.enum_benefit_provider_plan_billing_rules_coverage_group as enum ('EMPLOYEE', 'EMPLOYEE_AND_SPOUSE', 'EMPLOYEE_AND_CHILD', 'EMPLOYEE_AND_FAMILY');

create type benefits.enum_benefit_provider_plan_billing_rules_gender as enum ('FEMALE', 'MALE');

create type benefits.enum_benefit_provider_plan_contribution_rules_client_contrib as enum ('PERCENTAGE', 'FIXED_AMOUNT');

create type benefits.enum_benefit_provider_plan_contribution_rules_coverage_group as enum ('EMPLOYEE', 'EMPLOYEE_AND_SPOUSE', 'EMPLOYEE_AND_CHILD', 'EMPLOYEE_AND_FAMILY');

create type benefits.enum_benefit_provider_plan_contribution_rules_dependent_cont as enum ('PERCENTAGE', 'FIXED_AMOUNT');

create type benefits.enum_benefit_provider_plan_contribution_rules_employee_contr as enum ('PERCENTAGE', 'FIXED_AMOUNT');

create type benefits.enum_benefit_provider_plans_client_contribution_type as enum ('PERCENTAGE', 'FIXED_AMOUNT');

create type benefits.enum_benefit_provider_plans_employee_contribution_type as enum ('PERCENTAGE', 'FIXED_AMOUNT');

create type benefits.enum_benefit_provider_plans_price_period as enum ('MONTHLY', 'BIMONTHLY', 'BIWEEKLY');

create type benefits.enum_benefit_providers_benefit_type as enum ('HEALTHCARE', 'DENTAL', 'VISION', 'HSA', 'FSA', '401_K', 'LIFE_INSURANCE', 'LONG_TERM_DISABILITY', 'SHORT_TERM_DISABILITY', 'PENSION', 'CRITICAL_ILLNESS', 'ACCIDENT_INSURANCE', 'MEAL_VOUCHER');

create type benefits.enum_benefit_providers_billing_period_rule as enum ('NEXT_MONTH', 'RETROACTIVE', 'IMMEDIATELY', 'CUT_OFF');

create type benefits.enum_benefit_providers_billing_termination_strategy as enum ('END_OF_PAYMENT_CYCLE', 'TERMINATION_DATE', 'CUT_OFF_DATE');

create type benefits.enum_benefit_providers_client_contribution_type as enum ('PERCENTAGE', 'FIXED_AMOUNT');

create type benefits.enum_benefit_providers_contribution_settings as enum ('MANDATORY', 'OPTIONAL', 'UNAVAILABLE');

create type benefits.enum_benefit_providers_coverage_start_rule as enum ('NEXT_MONTH', 'RETROACTIVE', 'IMMEDIATELY', 'CUT_OFF');

create type benefits.enum_benefit_providers_coverage_termination_strategy as enum ('END_OF_PAYMENT_CYCLE', 'TERMINATION_DATE', 'CUT_OFF_DATE');

create type benefits.enum_benefit_providers_eligibility_rule as enum ('NUMBER_OF_DAYS', 'NUMBER_OF_MONTHS', 'FIRST_OF_MONTH_AFTER_DAYS');

create type benefits.enum_benefit_providers_enrollment_expiration_policy as enum ('OPT_OUT', 'ENROLL', 'NONE', 'FORCE_ENROLL');

create type benefits.enum_benefit_rejection_reasons_benefit_type as enum ('HEALTHCARE', 'DENTAL', 'VISION', 'HSA', 'FSA', '401_K', 'LIFE_INSURANCE', 'LONG_TERM_DISABILITY', 'SHORT_TERM_DISABILITY');

create type benefits.enum_benefit_settings_participation as enum ('MANDATORY', 'OPTIONAL', 'DISABLED');

create type benefits.enum_contract_benefit_recurring_items_status as enum ('PENDING', 'ACTIVE', 'EXITED');

create type benefits.enum_contract_benefits_allow_plan_selection as enum ('ALLOW_UPGRADE', 'ALLOW_DOWNGRADE', 'ALLOW_BOTH', 'ALLOW_NONE');

create type benefits.enum_contract_benefits_client_contribution_type as enum ('PERCENTAGE', 'FIXED_AMOUNT');

create type benefits.enum_contract_benefits_contract_type as enum ('EOR', 'GP', 'PEO', 'EMBEDDED');

create type benefits.enum_contract_benefits_contribution_period as enum ('MONTHLY', 'BIMONTHLY', 'BIWEEKLY');

create type benefits.enum_contract_benefits_employee_contribution_type as enum ('PERCENTAGE', 'FIXED_AMOUNT');

create type benefits.enum_contract_benefits_employee_gender as enum ('FEMALE', 'MALE');

create type benefits.enum_contract_benefits_status as enum ('AWAITING_CONTRACT_ACTIVATION', 'AWAITING_ENROLLMENT', 'ENROLLED_PENDING_PROCESS', 'ENROLLED', 'OPTED_OUT', 'OPTED_OUT_PENDING_PROCESS', 'EXPIRED');

create type benefits.enum_qualifying_life_events_event_type as enum ('MARRIAGE', 'DIVORCE', 'BIRTH', 'ADOPTION', 'GUARDIANSHIP', 'DEATH_OF_POLICY_HOLDER', 'LOSE_EXISTING_HEALTH_COVERAGE', 'LOSE_GOVERNMENT_PROVIDED_COVERAGE', 'AGING_OFF_PARENTS_PLAN', 'CHANGES_IN_RESIDENCE', 'OTHER');

create type benefits.enum_qualifying_life_events_status as enum ('AWAITING_APPROVAL', 'APPROVED', 'REJECTED');

create type benefits.enum_benefit_provider_plan_premium_scheme as enum ('SALARY_BASED', 'EMPLOYEE_BENEFIT');

create type benefits.enum_benefit_provider_plan_rate_structure as enum ('TIERED_PRICE', 'PREMIUM_BASED_RATE', 'SALARY_MULTIPLIER', 'FIXED_PRICE_AND_POLICY_AMOUNT', 'FIXED_ANNUAL_CONTRIBUTION', 'MULTIPLE_OF_EARNINGS', 'PRICE_PER_PERSON', 'WEEKLY_SALARY_MULTIPLIER', 'MONTHLY_SALARY_MULTIPLIER', 'FIXED_POLICY_AMOUNT_WITH_AGE_BANDED_RATES', 'MULTIPLE_RATED_ANNUAL_SALARY_MULTIPLIER', 'TIERED_SINGLE_AND_FAMILY_PRICE', 'ANNUAL_SALARY_MULTIPLIER');

/*
END ENUM TYPES
*/

/*
TABLES DEFINITION
*/

create table if not exists benefits.attachments
(
    id         uuid                     not null
        primary key,
    item_id    uuid                     not null,
    item_type  varchar(100)             not null,
    file_key   varchar(100)             not null,
    file_name  varchar(100)             not null,
    target_key varchar(100),
    created_at timestamp with time zone not null,
    updated_at timestamp with time zone not null
);

comment on table benefits.attachments is 'BA attachments.';

comment on column benefits.attachments.id is 'BA attachment id.';

comment on column benefits.attachments.item_id is 'External item id';

comment on column benefits.attachments.item_type is 'External item type';

comment on column benefits.attachments.file_key is 'The key of the attached file.';

comment on column benefits.attachments.file_name is 'The name of the attached file.';

comment on column benefits.attachments.target_key is 'The file target key for S3.';

comment on column benefits.attachments.created_at is 'The date and time of the creation of the record.';

comment on column benefits.attachments.updated_at is 'The date and time of the last update of the record.';

create index if not exists ba_attachments_index
    on benefits.attachments (item_id, item_type, file_name);

create table if not exists benefits.benefit_coverage_areas
(
    id            uuid                     not null
        primary key,
    name          varchar(100)             not null,
    from_zip_code varchar(10)              not null,
    to_zip_code   varchar(10)              not null,
    created_at    timestamp with time zone not null,
    updated_at    timestamp with time zone not null
);

comment on table benefits.benefit_coverage_areas is 'This table stores the coverage regions where benefits plans are available.';

comment on column benefits.benefit_coverage_areas.id is 'BenefitProviderPlanCoverageArea id.';

comment on column benefits.benefit_coverage_areas.name is 'The name for this coverage area.';

comment on column benefits.benefit_coverage_areas.from_zip_code is 'The starting zip code for this coverage area.';

comment on column benefits.benefit_coverage_areas.to_zip_code is 'The ending zip code for this coverage area.';

create unique index if not exists ba_benefit_coverage_areas_name_and_zip_codes_unique_index
    on benefits.benefit_coverage_areas (name, from_zip_code, to_zip_code);

create table if not exists benefits.benefit_dependents
(
    id                     uuid                                      not null
        primary key,
    benefit_percent        numeric(5, 2),
    benefit_precedence     integer,
    first_name             varchar(100)                              not null,
    last_name              varchar(100)                              not null,
    date_of_birth          date                                      not null,
    social_security_number varchar(11),
    home_phone             varchar(20)                               not null,
    work_phone             varchar(20),
    email                  varchar(300)                              not null,
    is_full_time_student   boolean default false                     not null,
    is_tobacco_user        boolean default false                     not null,
    has_disability         boolean default false                     not null,
    address                varchar(100)                              not null,
    address_line_2         varchar(100),
    zip                    varchar(10)                               not null,
    city                   varchar(100)                              not null,
    state                  varchar(100),
    country                varchar(2)                                not null
        references common.countries
        constraint ba_benefit_dependents_country_fkey1
            references common.countries,
    employee_id            integer                                   not null
        references public.profile,
    created_at             timestamp with time zone                  not null,
    updated_at             timestamp with time zone                  not null,
    dependent_type         benefits.enum_benefit_dependents_dependent_type not null,
    relation_type          benefits.enum_benefit_dependents_relation_type,
    beneficiary_type       benefits.enum_benefit_dependents_beneficiary_type,
    gender                 benefits.enum_benefit_dependents_gender         not null
);

comment on table benefits.benefit_dependents is 'This table stores dependents related to employees that receive benefit coverages.';

comment on column benefits.benefit_dependents.id is 'The ID of the dependent.';

comment on column benefits.benefit_dependents.benefit_percent is 'The percentage of the benefit that the dependent will receive.';

comment on column benefits.benefit_dependents.benefit_precedence is 'The order of precedence of the dependent when receiving the benefit.';

comment on column benefits.benefit_dependents.first_name is '<code><b>SENSITIVE</b></code> The first name of the dependent.';

comment on column benefits.benefit_dependents.last_name is '<code><b>SENSITIVE</b></code> The last name of the dependent.';

comment on column benefits.benefit_dependents.date_of_birth is 'Date of birth of the dependent.';

comment on column benefits.benefit_dependents.social_security_number is '<code><b>SENSITIVE</b></code> The dependent social security number.';

comment on column benefits.benefit_dependents.home_phone is '<code><b>SENSITIVE</b></code> The dependent home phone number.';

comment on column benefits.benefit_dependents.work_phone is '<code><b>SENSITIVE</b></code> The dependent work phone number.';

comment on column benefits.benefit_dependents.email is '<code><b>SENSITIVE</b></code> The dependent email address.';

comment on column benefits.benefit_dependents.is_full_time_student is '<code><b>SENSITIVE</b></code> If the dependent is a full time student.';

comment on column benefits.benefit_dependents.is_tobacco_user is '<code><b>SENSITIVE</b></code> If the dependent is a tobacco user.';

comment on column benefits.benefit_dependents.has_disability is '<code><b>SENSITIVE</b></code> If the dependent suffers a disability.';

comment on column benefits.benefit_dependents.address is '<code><b>SENSITIVE</b></code> Dependent address';

comment on column benefits.benefit_dependents.address_line_2 is '<code><b>SENSITIVE</b></code> Dependent address line 2';

comment on column benefits.benefit_dependents.zip is '<code><b>SENSITIVE</b></code> Dependent address zipcode';

comment on column benefits.benefit_dependents.city is '<code><b>SENSITIVE</b></code> Dependent city';

comment on column benefits.benefit_dependents.state is 'Dependent state';

comment on column benefits.benefit_dependents.country is 'Dependent country';

comment on column benefits.benefit_dependents.employee_id is 'The employee that was offered a benefit and is related to this dependent.';

comment on column benefits.benefit_dependents.created_at is 'Timestamp from when the dependent was created.';

comment on column benefits.benefit_dependents.updated_at is 'Timestamp from the last time the the dependent was updated.';

comment on column benefits.benefit_dependents.dependent_type is 'Whether the person is an "insurance beneficiary" or a "benefit dependent".';

comment on column benefits.benefit_dependents.relation_type is 'The type of relation between Employee and Dependent, whether this person is their Spouse or Child.';

comment on column benefits.benefit_dependents.beneficiary_type is 'Whether the person is a Primary or Contingent beneficiary. This affects the priority order when receiving insurance.';

comment on column benefits.benefit_dependents.gender is 'The gender of the dependent, whether they are Female or Male when signing to the benefit.';

create index if not exists ba_benefit_dependents_country_index
    on benefits.benefit_dependents (country);

create index if not exists ba_benefit_dependents_dependent_type_index
    on benefits.benefit_dependents (dependent_type);

create index if not exists ba_benefit_dependents_employee_id_index
    on benefits.benefit_dependents (employee_id);

create table if not exists benefits.benefit_providers
(
    id                                   uuid                                                                                                                                            not null
        primary key,
    name                                 varchar(100)                                                                                                                                    not null,
    website_url                          varchar(1200),
    legal_entity_id                      integer                                                                                                                                         not null
        references public."LegalEntities",
    country                              varchar(2)
        references common.countries,
    payroll_report_column_id             varchar(32)
        references employment.payroll_report_columns,
    created_at                           timestamp with time zone                                                                                                                        not null,
    updated_at                           timestamp with time zone                                                                                                                        not null,
    benefit_type                         benefits.enum_benefit_providers_benefit_type                                                                                                          not null,
    eligibility_rule                     benefits.enum_benefit_providers_eligibility_rule                                                                                                      not null,
    eligibility_value                    integer                                                                                                                                         not null,
    billing_period_rule                  benefits.enum_benefit_providers_billing_period_rule                                                                                                   not null,
    benefit_contribution_flat_limit      numeric(12, 2),
    is_plan_price_fixed                  boolean                                                 default false                                                                           not null,
    pricing_info_url                     varchar(255),
    is_unisure                           boolean                                                 default false                                                                           not null,
    is_active                            boolean                                                 default true                                                                            not null,
    admin_only                           boolean                                                 default false                                                                           not null,
    franchise_amount                     numeric(12, 2),
    quote_banner                         varchar(2000)                                           default NULL::character varying,
    onboarding_banner_for_client         varchar(2000)                                           default NULL::character varying,
    onboarding_banner_for_employee       varchar(2000)                                           default NULL::character varying,
    after_onboarding_banner_for_client   varchar(2000)                                           default NULL::character varying,
    after_onboarding_banner_for_employee varchar(2000)                                           default NULL::character varying,
    old_id                               integer,
    benefit_id                           integer
        references public.benefits,
    contribution_settings                benefits.enum_benefit_providers_contribution_settings,
    deleted_at                           timestamp with time zone,
    currency                             varchar(3)                                              default 'USD'::character varying                                                        not null
        references common.currencies,
    administered_by_deel                 boolean                                                 default false                                                                           not null,
    enrollment_expiration_policy         benefits.enum_benefit_providers_enrollment_expiration_policy  default 'NONE'::benefits.enum_benefit_providers_enrollment_expiration_policy                  not null,
    billing_termination_strategy         benefits.enum_benefit_providers_billing_termination_strategy  default 'END_OF_PAYMENT_CYCLE'::benefits.enum_benefit_providers_billing_termination_strategy  not null,
    coverage_termination_strategy        benefits.enum_benefit_providers_coverage_termination_strategy default 'END_OF_PAYMENT_CYCLE'::benefits.enum_benefit_providers_coverage_termination_strategy not null,
    billing_termination_value            integer,
    coverage_termination_value           integer,
    billing_period_value                 integer,
    coverage_start_rule                  benefits.enum_benefit_providers_coverage_start_rule,
    coverage_start_value                 integer
);

comment on table benefits.benefit_providers is 'This table stores benefit providers configured by organizations.';

comment on column benefits.benefit_providers.id is 'Benefit Provider id.';

comment on column benefits.benefit_providers.name is 'The name the Benefit Provider.';

comment on column benefits.benefit_providers.website_url is 'The benefit provider website url';

comment on column benefits.benefit_providers.legal_entity_id is 'The legal entity that uploaded this benefit provider.';

comment on column benefits.benefit_providers.country is 'Benefit Provider country';

comment on column benefits.benefit_providers.payroll_report_column_id is 'The employment.payroll_report_column this provider is associated with.';

comment on column benefits.benefit_providers.benefit_type is 'The type of benefit the provider offers.';

comment on column benefits.benefit_providers.eligibility_rule is 'The eligibility rule for the benefit plan, determining when an employee becomes eligible for benefits.';

comment on column benefits.benefit_providers.eligibility_value is 'The value of the eligibility rule. For example, if the eligibility rule is NUMBER_OF_DAYS, the value is the number of days an employee must be employed to be eligible for benefits.';

comment on column benefits.benefit_providers.billing_period_rule is 'The billing period rule for the provider, determining when an employee is first billed for benefits.';

comment on column benefits.benefit_providers.benefit_contribution_flat_limit is 'The benefit contribution flat limit of the benefit provider.';

comment on column benefits.benefit_providers.is_plan_price_fixed is 'Whether life insurance benefit has a fixed plan price';

comment on column benefits.benefit_providers.pricing_info_url is 'External URL to pricing details for a life insurance provider';

comment on column benefits.benefit_providers.is_unisure is 'The is unisure of the benefit provider.';

comment on column benefits.benefit_providers.is_active is 'The is active of the benefit provider.';

comment on column benefits.benefit_providers.admin_only is 'The admin only of the benefit provider.';

comment on column benefits.benefit_providers.franchise_amount is 'The franchise amount of the benefit provider.';

comment on column benefits.benefit_providers.quote_banner is 'Stores the banner message to be shown on the quote flow';

comment on column benefits.benefit_providers.onboarding_banner_for_client is 'Stores the post onboarding banner message for clients';

comment on column benefits.benefit_providers.onboarding_banner_for_employee is 'Stores the post onboarding banner message for employees';

comment on column benefits.benefit_providers.after_onboarding_banner_for_client is 'Stores the post onboarding banner message for clients';

comment on column benefits.benefit_providers.after_onboarding_banner_for_employee is 'Stores the post onboarding banner message for employees';

comment on column benefits.benefit_providers.old_id is 'The old id of the benefit provider.';

comment on column benefits.benefit_providers.contribution_settings is 'Shows if the client contribution is required, optional or forbidden';

comment on column benefits.benefit_providers.deleted_at is 'The date the benefit provider was deleted.';

comment on column benefits.benefit_providers.currency is 'The currency of the benefit provider.';

comment on column benefits.benefit_providers.administered_by_deel is 'Whether the benefit provider is administered by Deel';

comment on column benefits.benefit_providers.enrollment_expiration_policy is 'Enrollment expiration policy for the benefit';

comment on column benefits.benefit_providers.billing_termination_strategy is 'Billing termination strategy for the benefit';

comment on column benefits.benefit_providers.coverage_termination_strategy is 'Coverage termination strategy for the benefit';

comment on column benefits.benefit_providers.billing_termination_value is 'Billing termination day used for cut-off strategy';

comment on column benefits.benefit_providers.coverage_termination_value is 'Coverage termination day used for cut-off strategy';

comment on column benefits.benefit_providers.billing_period_value is 'Benefit provider billing rule value.';

comment on column benefits.benefit_providers.coverage_start_rule is 'The coverage start date rule for the provider, determining when an employee is first covered for benefits.';

comment on column benefits.benefit_providers.coverage_start_value is 'Benefit provider coverage start value.';

create table if not exists benefits.benefit_provider_plans
(
    id                            uuid                                                                                                        not null
        primary key,
    name                          varchar(100)                                                                                                not null,
    allows_dependents             boolean                                   default false                                                     not null,
    ba_benefit_provider_id        uuid                                                                                                        not null
        references benefits.benefit_providers,
    created_at                    timestamp with time zone                                                                                    not null,
    updated_at                    timestamp with time zone                                                                                    not null,
    provider_information          jsonb                                     default '{}'::jsonb                                               not null,
    employee_contribution_type    benefits.enum_benefit_provider_plans_employee_contribution_type,
    employee_contribution_value   numeric(12, 2),
    employee_max_contribution     numeric(12, 2),
    employee_min_contribution     numeric(12, 2),
    client_contribution_type      benefits.enum_benefit_provider_plans_client_contribution_type,
    client_contribution_value     numeric(12, 2),
    client_min_contribution       numeric(12, 2),
    client_max_contribution       numeric(12, 2),
    policy_number                 varchar(50)                               default NULL::character varying,
    is_hsa_compatible             boolean                                   default false                                                     not null,
    description                   varchar(300),
    old_id                        integer,
    deleted_at                    timestamp with time zone,
    price                         numeric(12, 2)                            default 0                                                         not null,
    is_draft                      boolean                                   default false                                                     not null,
    rate_structure                benefits.enum_benefit_provider_plan_rate_structure default 'TIERED_PRICE'::benefits.enum_benefit_provider_plan_rate_structure not null,
    plan_url                      varchar(250),
    multiple_of_earnings          numeric(5, 2)                             default 0                                                         not null,
    age_of_majority               integer,
    max_ee_age                    integer,
    max_adult_dep_age             integer,
    max_minor_dep_age             integer,
    max_billable_adult_dependents integer,
    max_billable_child_dependents integer,
    max_fts_child_dep_age         integer,
    max_disabled_child_dep_age    integer
);

comment on table benefits.benefit_provider_plans is 'This table stores plans offered by a particular BenefitProvider.';

comment on column benefits.benefit_provider_plans.id is 'BenefitProviderPlan id.';

comment on column benefits.benefit_provider_plans.name is 'The name for this plan.';

comment on column benefits.benefit_provider_plans.allows_dependents is 'True if plan allows to add dependents.';

comment on column benefits.benefit_provider_plans.ba_benefit_provider_id is 'The benefit provider that offers this plan.';

comment on column benefits.benefit_provider_plans.provider_information is 'This column provides coverage limit details for insurance plans, helping users compare and select the best plan based on their needs.';

comment on column benefits.benefit_provider_plans.employee_contribution_type is 'This is the type the employee contribution limits are based on.';

comment on column benefits.benefit_provider_plans.employee_contribution_value is 'This is a mandatory contribution value the employee must pay.';

comment on column benefits.benefit_provider_plans.employee_max_contribution is 'Maximum amount the employee is allowed to contribute to their benefit';

comment on column benefits.benefit_provider_plans.employee_min_contribution is 'Minimum amount the employee is requested to contribute to their benefit';

comment on column benefits.benefit_provider_plans.client_contribution_type is 'This is the type the client contribution limits are based on.';

comment on column benefits.benefit_provider_plans.client_contribution_value is 'This is the value the client is expected to contribute to the Employee Benefit.';

comment on column benefits.benefit_provider_plans.client_min_contribution is 'Minimum amount the client is willing to contribute to the employee''s benefit';

comment on column benefits.benefit_provider_plans.client_max_contribution is 'Maximum amount the client is willing to contribute to the employee''s benefit';

comment on column benefits.benefit_provider_plans.policy_number is 'This is the value that the benefit provider company uses to identify the plan. Although this is called a number, it can be alphanumeric or null. This is unique per benefit provider company.';

comment on column benefits.benefit_provider_plans.is_hsa_compatible is 'Whether the plan is HSA compatible or not. This means that an employee enrolled into this plan is eligible to open an Health Savings Account (if their employer offers one).';

comment on column benefits.benefit_provider_plans.description is 'The description of the plan';

comment on column benefits.benefit_provider_plans.old_id is 'The old id of the benefit provider plan.';

comment on column benefits.benefit_provider_plans.deleted_at is 'The date when the plan was deleted.';

comment on column benefits.benefit_provider_plans.price is 'The price of the benefit provider plan for the employee or dependent.';

comment on column benefits.benefit_provider_plans.is_draft is 'whether a provider plan has been saved as draft';

comment on column benefits.benefit_provider_plans.rate_structure is 'Rate structure for the benefit provider plan.';

comment on column benefits.benefit_provider_plans.plan_url is 'The url for this plan.';

comment on column benefits.benefit_provider_plans.multiple_of_earnings is 'A rate used to calculate the policy amount based on the employee annual salary, by multiplying the employee annual salary by this rate.';

comment on column benefits.benefit_provider_plans.age_of_majority is 'The age at which a dependent is considered an adult.';

comment on column benefits.benefit_provider_plans.max_ee_age is 'The maximum age an employee can be to be eligible for this plan.';

comment on column benefits.benefit_provider_plans.max_adult_dep_age is 'The maximum age an adult or spouse dependent can be to be eligible for this plan.';

comment on column benefits.benefit_provider_plans.max_minor_dep_age is 'The maximum age a minor dependent can be to be eligible for this plan.';

comment on column benefits.benefit_provider_plans.max_billable_adult_dependents is 'The maximum number of adult dependents that can be billed for this plan.';

comment on column benefits.benefit_provider_plans.max_billable_child_dependents is 'The maximum number of child dependents that can be billed for this plan.';

comment on column benefits.benefit_provider_plans.max_fts_child_dep_age is 'The maximum age for a child full-time student to be allowed as dependent.';

comment on column benefits.benefit_provider_plans.max_disabled_child_dep_age is 'The maximum age for a child with disabilities to be as allowed dependent.';

create table if not exists benefits.benefit_provider_plan_billing_rules
(
    id                        uuid                                                                                                                                                not null
        primary key,
    starting_age              smallint                                                                                                                                            not null,
    price                     numeric(12, 2)                                                                                                                                      not null,
    premium_rate              numeric(12, 2),
    premium_for_smoker        numeric(12, 2),
    premium_for_disability    numeric(12, 2),
    premium_for_gender        numeric(12, 2),
    benefit_provider_plan_id  uuid                                                                                                                                                not null
        constraint ba_benefit_provider_plan_billing__benefit_provider_plan_id_fkey
            references benefits.benefit_provider_plans,
    created_at                timestamp with time zone                                                                                                                            not null,
    updated_at                timestamp with time zone                                                                                                                            not null,
    coverage_group            benefits.enum_benefit_provider_plan_billing_rules_coverage_group                                                                                          not null,
    gender                    benefits.enum_benefit_provider_plan_billing_rules_gender,
    billing_frequency         benefits.enum_benefit_provider_plan_billing_rules_billing_frequency   default 'MONTHLY'::benefits.enum_benefit_provider_plan_billing_rules_billing_frequency    not null,
    currency                  varchar(3)                                                      default 'USD'::character varying                                                    not null
        references common.currencies,
    premium_scheme            benefits.enum_benefit_provider_plan_premium_scheme                       default 'SALARY_BASED'::benefits.enum_benefit_provider_plan_premium_scheme                   not null,
    price_per_adult_dependent numeric(12, 2),
    price_per_minor_dependent numeric(12, 2),
    fixed_policy_amount       numeric(12, 2),
    coverage_beneficiary_type benefits.enum_benefit_provider_plan_billing_rules_coverage_beneficiar default 'EMPLOYEE'::benefits.enum_benefit_provider_plan_billing_rules_coverage_beneficiar not null
);

comment on table benefits.benefit_provider_plan_billing_rules is 'The benefit provider plan billing rules table contains the rules for how to calculate the cost of a benefit provider plan based on the employee or dependent information, such as age, gender, smoker status, and disabilities.';

comment on column benefits.benefit_provider_plan_billing_rules.id is 'The ID of the benefit provider plan billing rule.';

comment on column benefits.benefit_provider_plan_billing_rules.starting_age is 'The starting age of the employee or dependent that the billing rule applies to.';

comment on column benefits.benefit_provider_plan_billing_rules.price is 'The price of the benefit provider plan for the employee or dependent.';

comment on column benefits.benefit_provider_plan_billing_rules.premium_rate is 'The rate by which the benefit cost is calculated, by dividing annual contribution by this rate, and then multiplying by matching premiums. This rate is used to calculate contribution of some benefits, such as life insurance.';

comment on column benefits.benefit_provider_plan_billing_rules.premium_for_smoker is 'The premium for the employee or dependent if they are a smoker. This is multiplied by the result of the premium rate to get the final cost for smokers.';

comment on column benefits.benefit_provider_plan_billing_rules.premium_for_disability is 'The premium for the employee or dependent if they have a disability. This is multiplied by the result of the premium rate to get the final cost for people with disabilities.';

comment on column benefits.benefit_provider_plan_billing_rules.premium_for_gender is 'The premium for the employee or dependent based on their gender. This is multiplied by the result of the premium rate to get the final cost for their gender.';

comment on column benefits.benefit_provider_plan_billing_rules.benefit_provider_plan_id is 'The ID of the benefit provider plan that the contribution rule refers to.';

comment on column benefits.benefit_provider_plan_billing_rules.created_at is 'Timestamp from the time the billing rule was created.';

comment on column benefits.benefit_provider_plan_billing_rules.updated_at is 'Timestamp from the time the billing rule was last updated.';

comment on column benefits.benefit_provider_plan_billing_rules.coverage_group is 'The coverage group of the benefit provider plan billing rule. This is the group of people that the billing rule applies to.';

comment on column benefits.benefit_provider_plan_billing_rules.gender is 'The gender of the employee or dependent that the billing rule applies to.';

comment on column benefits.benefit_provider_plan_billing_rules.billing_frequency is 'The billing frequency the plan price is based on. For example, if the plan price is $1000 and the billing frequency is monthly, the plan price will be $1000/month';

comment on column benefits.benefit_provider_plan_billing_rules.currency is 'The currency of the billing rule.';

comment on column benefits.benefit_provider_plan_billing_rules.premium_scheme is 'Premium scheme for the plan billing rule.';

comment on column benefits.benefit_provider_plan_billing_rules.price_per_adult_dependent is 'The price of the benefit provider plan for each adult dependent covered.';

comment on column benefits.benefit_provider_plan_billing_rules.price_per_minor_dependent is 'The price of the benefit provider plan for each minor dependent covered.';

comment on column benefits.benefit_provider_plan_billing_rules.fixed_policy_amount is 'The amount of money that the employee or dependent is insured for. This is an amount of money that the insurance company will pay out to the beneficiary of the policy when the insured person dies or other qualifying event occurs.';

comment on column benefits.benefit_provider_plan_billing_rules.coverage_beneficiary_type is 'The type of beneficiary the billing rule applies to.';

create index if not exists ba_benefit_provider_plan_billing_rules_coverage_group_index
    on benefits.benefit_provider_plan_billing_rules (coverage_group);

create index if not exists ba_benefit_provider_plan_billing_rules_gender_index
    on benefits.benefit_provider_plan_billing_rules (gender);

create index if not exists ba_benefit_provider_plan_billing_rules_starting_age_index
    on benefits.benefit_provider_plan_billing_rules (starting_age);

create unique index if not exists ba_benefit_provider_plan_billing_rules_unique_coverages_index
    on benefits.benefit_provider_plan_billing_rules (benefit_provider_plan_id, billing_frequency, coverage_group,
                                                      gender, coverage_beneficiary_type, starting_age);

create table if not exists benefits.benefit_provider_plan_contribution_rules
(
    id                                    uuid                                                                                                                                                    not null
        primary key,
    client_max_contribution_to_ee_cost    numeric(12, 2),
    client_contribution_to_dep_value      numeric(12, 2)                                                  default 0,
    benefit_provider_plan_id              uuid                                                                                                                                                    not null
        constraint ba_benefit_provider_plan_contribu_benefit_provider_plan_id_fkey
            references benefits.benefit_provider_plans,
    created_at                            timestamp with time zone                                                                                                                                not null,
    updated_at                            timestamp with time zone                                                                                                                                not null,
    coverage_group                        benefits.enum_benefit_provider_plan_contribution_rules_coverage_group                                                                                         not null,
    client_contribution_to_ee_limit_type  benefits.enum_benefit_provider_plan_contribution_rules_employee_contr,
    client_contribution_to_dep_type       benefits.enum_benefit_provider_plan_contribution_rules_dependent_cont default 'FIXED_AMOUNT'::benefits.enum_benefit_provider_plan_contribution_rules_dependent_cont,
    employee_contribution_limit_type      benefits.enum_benefit_provider_plan_contribution_rules_employee_contr,
    employee_max_contribution             numeric(12, 2),
    employee_min_contribution             numeric(12, 2),
    client_min_contribution_to_ee_cost    numeric(12, 2),
    client_contribution_to_ee_type        benefits.enum_benefit_provider_plan_contribution_rules_client_contrib default 'FIXED_AMOUNT'::benefits.enum_benefit_provider_plan_contribution_rules_client_contrib not null,
    client_contribution_to_ee_value       numeric(12, 2)                                                  default 0                                                                               not null,
    client_contribution_to_dep_limit_type benefits.enum_benefit_provider_plan_contribution_rules_client_contrib,
    client_max_contribution_to_dep_cost   numeric(12, 2),
    client_min_contribution_to_dep_cost   numeric(12, 2)
);

comment on table benefits.benefit_provider_plan_contribution_rules is 'The table containing the benefit provider plan contribution rules. This defines how clients contribute to the cost of the benefit from employees.';

comment on column benefits.benefit_provider_plan_contribution_rules.id is 'The ID of the benefit provider plan contribution rule.';

comment on column benefits.benefit_provider_plan_contribution_rules.client_max_contribution_to_ee_cost is 'The maximum amount of money the Client is willing to contribute to the benefit cost coming from the Employee.';

comment on column benefits.benefit_provider_plan_contribution_rules.client_contribution_to_dep_value is 'The value the Client pays for the Dependents cost. This is used for Rate Structures with static contributions where the EE cannot make the selection themselves.';

comment on column benefits.benefit_provider_plan_contribution_rules.benefit_provider_plan_id is 'The ID of the benefit provider plan that the contribution rule refers to.';

comment on column benefits.benefit_provider_plan_contribution_rules.created_at is 'Timestamp from the time the contribution rule was created.';

comment on column benefits.benefit_provider_plan_contribution_rules.updated_at is 'Timestamp from the time the contribution rule was last updated.';

comment on column benefits.benefit_provider_plan_contribution_rules.coverage_group is 'The coverage group of the benefit provider plan contribution rule. This is the group of people that are covered by the benefit, and the group that the contribution rule applies to.';

comment on column benefits.benefit_provider_plan_contribution_rules.client_contribution_to_ee_limit_type is 'The type of the limits the Client is willing to contribute to the benefit cost coming from the Employee.';

comment on column benefits.benefit_provider_plan_contribution_rules.client_contribution_to_dep_type is 'The type of the contribution the Client pays for the Dependents cost. This is used for Rate Structures with static contributions where the EE cannot make the selection themselves.';

comment on column benefits.benefit_provider_plan_contribution_rules.employee_contribution_limit_type is 'The value type of the limits the Employee is allowed to contribute to the total benefit cost.';

comment on column benefits.benefit_provider_plan_contribution_rules.employee_max_contribution is 'The maximum amount of money the Employee is allowed to contribute to the total benefit cost.';

comment on column benefits.benefit_provider_plan_contribution_rules.employee_min_contribution is 'The minimum amount of money the Employee is allowed to contribute to the total benefit cost.';

comment on column benefits.benefit_provider_plan_contribution_rules.client_min_contribution_to_ee_cost is 'The minimum amount of money the Client is willing to contribute to the benefit cost coming from the Employee.';

comment on column benefits.benefit_provider_plan_contribution_rules.client_contribution_to_ee_type is 'The type of the contribution the Client pays for the Employee cost. This is used for Rate Structures with static contributions where the EE cannot make the selection themselves.';

comment on column benefits.benefit_provider_plan_contribution_rules.client_contribution_to_ee_value is 'The value the Client pays for the Employee cost. This is used for Rate Structures with static contributions where the EE cannot make the selection themselves.';

comment on column benefits.benefit_provider_plan_contribution_rules.client_contribution_to_dep_limit_type is 'The type of the limits the Client is willing to contribute to the benefit cost coming from the Dependents.';

comment on column benefits.benefit_provider_plan_contribution_rules.client_max_contribution_to_dep_cost is 'The maximum amount of money the Client is willing to contribute to the benefit cost coming from the Dependents.';

comment on column benefits.benefit_provider_plan_contribution_rules.client_min_contribution_to_dep_cost is 'The minimum amount of money the Client is willing to contribute to the benefit cost coming from the Dependents.';

create index if not exists ba_benefit_provider_plan_contribution_rules_coverage_group_inde
    on benefits.benefit_provider_plan_contribution_rules (coverage_group);

create unique index if not exists ba_benefit_provider_plan_contribution_rules_unique_index
    on benefits.benefit_provider_plan_contribution_rules (benefit_provider_plan_id, coverage_group);

create table if not exists benefits.benefit_provider_plan_coverage_areas
(
    ba_benefit_coverage_area_id uuid not null
        constraint ba_benefit_provider_plan_cover_ba_benefit_coverage_area_id_fkey
            references benefits.benefit_coverage_areas,
    ba_benefit_provider_plan_id uuid not null
        constraint ba_benefit_provider_plan_cover_ba_benefit_provider_plan_id_fkey
            references benefits.benefit_provider_plans
);

comment on table benefits.benefit_provider_plan_coverage_areas is 'This table associates BenefitProviderPlans with its BenefitCoverageAreas.';

comment on column benefits.benefit_provider_plan_coverage_areas.ba_benefit_coverage_area_id is 'The id of the coverage area.';

comment on column benefits.benefit_provider_plan_coverage_areas.ba_benefit_provider_plan_id is 'The id of the benefit provider plan.';

create unique index if not exists ba_benefit_provider_plan_coverage_areas_unique_index
    on benefits.benefit_provider_plan_coverage_areas (ba_benefit_coverage_area_id, ba_benefit_provider_plan_id);

create unique index if not exists ba_benefit_provider_plans_name_ba_benefit_provider_id_deleted_a
    on benefits.benefit_provider_plans (name, ba_benefit_provider_id, deleted_at);

create index if not exists ba_benefit_providers_benefit_type_index
    on benefits.benefit_providers (benefit_type);

create index if not exists ba_benefit_providers_deleted_at_index
    on benefits.benefit_providers (deleted_at);

create index if not exists ba_benefit_providers_legal_entity_id_index
    on benefits.benefit_providers (legal_entity_id);

create unique index if not exists ba_benefit_providers_unique_per_type_and_org_index
    on benefits.benefit_providers (name, benefit_type, legal_entity_id, country);

create index if not exists benefit_providers_name_trigram_ginix
    on benefits.benefit_providers using gin (name gin_trgm_ops);

create table if not exists benefits.benefit_settings
(
    legal_entity_id integer not null
        references public."LegalEntities",
    benefit_id      integer not null
        references public.benefits,
    participation   benefits.enum_benefit_settings_participation
);

comment on column benefits.benefit_settings.legal_entity_id is 'reference to the LegalEntity';

comment on column benefits.benefit_settings.benefit_id is 'reference to the benefit';

comment on column benefits.benefit_settings.participation is 'Stores the rule associated to the benefit in the LegalEntity';

create unique index if not exists ba_benefit_settings_legal_entity_id_benefit_id
    on benefits.benefit_settings (legal_entity_id, benefit_id);

create table if not exists benefits.contract_benefit_ingests
(
    id                     uuid                     not null
        primary key,
    ba_contract_benefit_id uuid                     not null,
    user_id                integer
        references public.profile,
    created_at             timestamp with time zone not null,
    benefit_id             integer
        references public.benefits,
    contract_id            integer
        references public.contract
);

comment on table benefits.contract_benefit_ingests is 'The ingests for a contract benefit';

comment on column benefits.contract_benefit_ingests.ba_contract_benefit_id is 'The contract benefit this ingest is for';

comment on column benefits.contract_benefit_ingests.user_id is 'The user who made the ingest';

comment on column benefits.contract_benefit_ingests.created_at is 'The date of the ingest';

comment on column benefits.contract_benefit_ingests.benefit_id is 'The benefit assigned to this benefit ingest.';

comment on column benefits.contract_benefit_ingests.contract_id is 'The contract assigned to this benefit ingest.';

create index if not exists ba_contract_benefit_ingests_ba_contract_benefit_id_created_at_i
    on benefits.contract_benefit_ingests (ba_contract_benefit_id, created_at);

create index if not exists ba_contract_benefit_ingests_contract_id_benefit_id_created_at_i
    on benefits.contract_benefit_ingests (contract_id, benefit_id, created_at);

create table if not exists benefits.cross_entity_discrimination
(
    id         uuid                     not null
        primary key,
    benefit_id integer                  not null
        references public.benefits,
    country    varchar(2)               not null
        references common.countries,
    is_enabled boolean default false    not null,
    created_at timestamp with time zone not null,
    updated_at timestamp with time zone not null
);

comment on table benefits.cross_entity_discrimination is 'This table is used to define a cross discrimination rule for a group of legal entities for a benefit in an specific country. Grouped legal entities will be found in table ba_cross_entity_discrimination_legal_entities';

comment on column benefits.cross_entity_discrimination.benefit_id is 'Reference to the benefit associated with the cross discrimination rule.';

comment on column benefits.cross_entity_discrimination.country is 'ISO 3166-1 Alpha-2 country code. The country where the cross discrimination happens.';

comment on column benefits.cross_entity_discrimination.is_enabled is 'True if the cross discrimination is enabled for this benefit in this country.';

create table if not exists benefits.cross_entity_discrimination_legal_entities
(
    legal_entity_id                integer not null
        constraint ba_cross_entity_discrimination_legal_entit_legal_entity_id_fkey
            references public."LegalEntities",
    cross_entity_discrimination_id uuid    not null
        constraint ba_cross_entity_discriminatio_cross_entity_discrimination__fkey
            references benefits.cross_entity_discrimination
);

comment on table benefits.cross_entity_discrimination_legal_entities is 'This table is used to group legal entities into one cross discrimination rule.';

comment on column benefits.cross_entity_discrimination_legal_entities.legal_entity_id is 'Reference to the legal entity attached to the cross entity discrimination.';

comment on column benefits.cross_entity_discrimination_legal_entities.cross_entity_discrimination_id is 'Reference to the cross discrimination rule.';

create table if not exists benefits.discrimination_benefits
(
    legal_entity_id integer not null
        references public."LegalEntities",
    benefit_id      integer not null
        references public.benefits
);

comment on column benefits.discrimination_benefits.legal_entity_id is 'reference to the LegalEntity';

comment on column benefits.discrimination_benefits.benefit_id is 'reference to the benefit';

create unique index if not exists ba_discrimination_benefits_legal_entity_id_benefit_id
    on benefits.discrimination_benefits (legal_entity_id, benefit_id);

create table if not exists benefits.open_enrollments
(
    id                            uuid                     not null
        primary key,
    starts_at                     date                     not null,
    ends_at                       date                     not null,
    send_email_reminders          boolean default false    not null,
    email_reminder_custom_message varchar(2000),
    is_processed                  boolean default false    not null,
    benefit_provider_id           uuid                     not null
        unique
        references benefits.benefit_providers,
    created_at                    timestamp with time zone not null,
    updated_at                    timestamp with time zone not null
);

comment on table benefits.open_enrollments is 'This table stores the open enrollment configuration for a benefit provider.';

comment on column benefits.open_enrollments.id is 'Open Enrollment id.';

comment on column benefits.open_enrollments.starts_at is 'The date when the open enrollment starts. This is used to determine the open enrollment period.';

comment on column benefits.open_enrollments.ends_at is 'The date when the open enrollment ends. This is used to determine the open enrollment period.';

comment on column benefits.open_enrollments.send_email_reminders is 'Whether an e-mail reminder should be send';

comment on column benefits.open_enrollments.email_reminder_custom_message is 'Custom email reminder message.';

comment on column benefits.open_enrollments.is_processed is 'Whether it has already been consumed to update contract benefits start and end dates';

create index if not exists ba_open_enrollments_date_range_index
    on benefits.open_enrollments (starts_at, ends_at);

create table if not exists benefits.pension_contribution_options
(
    id                  uuid                     not null
        primary key,
    benefit_provider_id uuid                     not null
        references benefits.benefit_providers,
    amount              numeric(12, 2)           not null,
    created_at          timestamp with time zone not null,
    updated_at          timestamp with time zone not null,
    deleted_at          timestamp with time zone
);

comment on table benefits.pension_contribution_options is 'Store various contribution amount that a provider could have';

comment on column benefits.pension_contribution_options.id is 'Entry id';

comment on column benefits.pension_contribution_options.benefit_provider_id is 'Foreign key that refers to the benefit provider id';

comment on column benefits.pension_contribution_options.amount is 'Suggested amount';

comment on column benefits.pension_contribution_options.created_at is 'Date when entry was inserted';

comment on column benefits.pension_contribution_options.updated_at is 'Date when entry was updated';

comment on column benefits.pension_contribution_options.deleted_at is 'Date when entry was soft deleted';

create unique index if not exists ba_pension_contribution_options_unique_index
    on benefits.pension_contribution_options (benefit_provider_id, amount)
    where (deleted_at IS NULL);

create table if not exists benefits.qualifying_life_events
(
    id               uuid                                                                                                     not null
        primary key,
    rejection_reason varchar(600),
    reviewed_at      date,
    reviewed_by      integer
        references public.profile,
    uploaded_by      integer                                                                                                  not null
        references public.profile,
    event_date       date                                                                                                     not null,
    created_at       timestamp with time zone                                                                                 not null,
    updated_at       timestamp with time zone                                                                                 not null,
    status           benefits.enum_qualifying_life_events_status default 'AWAITING_APPROVAL'::benefits.enum_qualifying_life_events_status not null,
    event_type       benefits.enum_qualifying_life_events_event_type                                                                not null
);

comment on table benefits.qualifying_life_events is 'This table stores Qualifying Life Events created by employees and approved by admins.';

comment on column benefits.qualifying_life_events.id is 'Qualifying Life Event id.';

comment on column benefits.qualifying_life_events.rejection_reason is 'The reason for rejecting the Qualifying Life Event.';

comment on column benefits.qualifying_life_events.reviewed_at is 'The date when the Qualifying Life Event was reviewed by an admin.';

comment on column benefits.qualifying_life_events.reviewed_by is 'The admin who reviewed the Qualifying Life Event.';

comment on column benefits.qualifying_life_events.uploaded_by is 'The employee who uploaded the Qualifying Life Event.';

comment on column benefits.qualifying_life_events.event_date is 'The date of the Qualifying Life Event.';

comment on column benefits.qualifying_life_events.created_at is 'The date when the Qualifying Life Event was created.';

comment on column benefits.qualifying_life_events.updated_at is 'The date when the Qualifying Life Event was last updated.';

comment on column benefits.qualifying_life_events.status is 'The status of the Qualifying Life Event.';

comment on column benefits.qualifying_life_events.event_type is 'The type of the Qualifying Life Event.';

create table if not exists benefits.contract_benefits
(
    id                                  uuid                                                                                                                        not null
        primary key,
    ended_at                            timestamp with time zone,
    client_contribution_value           numeric(12, 2),
    client_min_contribution             numeric(12, 2),
    client_max_contribution             numeric(12, 2),
    selected_benefit_provider_id        uuid
        references benefits.benefit_providers,
    selected_benefit_provider_plan_id   uuid
        references benefits.benefit_provider_plans,
    contract_id                         integer                                                                                                                     not null
        references public.contract,
    created_at                          timestamp with time zone                                                                                                    not null,
    updated_at                          timestamp with time zone                                                                                                    not null,
    status                              benefits.enum_contract_benefits_status                   default 'AWAITING_CONTRACT_ACTIVATION'::benefits.enum_contract_benefits_status not null,
    client_contribution_type            benefits.enum_contract_benefits_client_contribution_type default 'FIXED_AMOUNT'::benefits.enum_contract_benefits_client_contribution_type,
    employee_period_contribution        numeric(12, 2),
    client_period_contribution          numeric(12, 2),
    employee_coverage_cost              numeric(12, 2),
    dependents_coverage_cost            numeric(12, 2),
    enrolled_at                         timestamp with time zone,
    contribution_period                 benefits.enum_contract_benefits_contribution_period,
    employee_total_contribution         numeric(12, 2),
    employee_contribution_type          benefits.enum_contract_benefits_employee_contribution_type,
    employee_contribution_value         numeric(12, 2),
    employee_max_contribution           numeric(12, 2),
    employee_min_contribution           numeric(12, 2),
    client_total_contribution           numeric(12, 2),
    employee_age                        smallint,
    employee_gender                     benefits.enum_contract_benefits_employee_gender,
    employee_is_tobacco_user            boolean                                            default false                                                            not null,
    employee_has_disability             boolean                                            default false                                                            not null,
    benefit_enrollment_window_starts_at timestamp with time zone,
    benefit_enrollment_window_ends_at   timestamp with time zone,
    first_billing_date                  timestamp with time zone,
    rejection_reason                    varchar(100),
    old_id                              integer,
    deleted_at                          timestamp with time zone,
    contract_type                       benefits.enum_contract_benefits_contract_type,
    cover_all                           boolean                                            default false                                                            not null,
    cover_dependents                    boolean                                            default false                                                            not null,
    number_of_dependents                integer                                            default 0                                                                not null,
    offered_by_client                   boolean                                            default false                                                            not null,
    registration_number                 varchar(255),
    expiration_date                     timestamp with time zone,
    offered_through_oe_id               uuid
        references benefits.open_enrollments,
    offered_through_qle_id              uuid
        references benefits.qualifying_life_events,
    coverage_start_date                 timestamp with time zone,
    allow_plan_selection                benefits.enum_contract_benefits_allow_plan_selection     default 'ALLOW_BOTH'::benefits.enum_contract_benefits_allow_plan_selection     not null,
    coverage_ended_at                   timestamp with time zone,
    billing_ended_at                    timestamp with time zone
);

comment on table benefits.contract_benefits is 'This table associates contracts with provided benefits, and the agreed contributions and costs for the contract.';

comment on column benefits.contract_benefits.id is 'ContractBenefit id.';

comment on column benefits.contract_benefits.ended_at is 'Date since the benefit completed its cycle and is no longer available for the user.';

comment on column benefits.contract_benefits.client_contribution_value is 'This is the original value the client has to contribute to the benefit.';

comment on column benefits.contract_benefits.client_min_contribution is 'Minimum amount the client is willing to contribute to the employee''s benefit';

comment on column benefits.contract_benefits.client_max_contribution is 'Maximum amount the client is willing to contribute to the employee''s benefit';

comment on column benefits.contract_benefits.selected_benefit_provider_id is 'The benefit provider selected by the client.';

comment on column benefits.contract_benefits.selected_benefit_provider_plan_id is 'The BenefitProviderPlan selected by the Employee.';

comment on column benefits.contract_benefits.contract_id is 'The contract assigned to this benefit.';

comment on column benefits.contract_benefits.status is 'ContractBenefit status.';

comment on column benefits.contract_benefits.client_contribution_type is 'Stores the client contribution type at the moment of enrollment.';

comment on column benefits.contract_benefits.employee_period_contribution is 'The periodic contribution cost the Employee has to pay for the benefit. Client and Employee contributions add up to the total benefit cost. This price period is based on contributionPeriod';

comment on column benefits.contract_benefits.client_period_contribution is 'The periodic contribution cost the Client has to pay for the benefit. Client and Employee contributions add up to the total benefit cost. This price period is based on contributionPeriod';

comment on column benefits.contract_benefits.employee_coverage_cost is 'This refers to the periodic cost of covering the employee''s enrollment in the benefit program. This is part of the total cost breakdown.';

comment on column benefits.contract_benefits.dependents_coverage_cost is 'This refers to the periodic cost of covering the dependents'' enrollments in the benefit program. This is part of the total cost breakdown.';

comment on column benefits.contract_benefits.enrolled_at is 'The timestamp from the moment the Employee enrolls into an offered benefit.';

comment on column benefits.contract_benefits.contribution_period is 'The period in which the benefit contribution cost is charged to the Employee.';

comment on column benefits.contract_benefits.employee_total_contribution is 'This is the anual value the employee committed to pay for the benefit. This total is the result of adding all employee periodical contributions over a full year duration.';

comment on column benefits.contract_benefits.employee_contribution_type is 'This is the type the employee contribution limits are based on.';

comment on column benefits.contract_benefits.employee_contribution_value is 'This is the original value the employee has to contribute to their benefit.';

comment on column benefits.contract_benefits.employee_max_contribution is 'Maximum amount the employee is allowed to contribute to their benefit';

comment on column benefits.contract_benefits.employee_min_contribution is 'Minimum amount the employee is requested to contribute to their benefit';

comment on column benefits.contract_benefits.client_total_contribution is 'This is the total value the client committed to pay for the employee benefit. This total is the result of adding all client periodical contributions over the contract_benefit duration.';

comment on column benefits.contract_benefits.employee_age is 'Employee age at the time of enrollment';

comment on column benefits.contract_benefits.employee_gender is 'Employee gender at the time of enrollment';

comment on column benefits.contract_benefits.employee_is_tobacco_user is 'Employee tobacco user status at the time of enrollment';

comment on column benefits.contract_benefits.employee_has_disability is 'Employee disability status at the time of enrollment';

comment on column benefits.contract_benefits.benefit_enrollment_window_starts_at is 'The date the benefit becomes available to enroll in.';

comment on column benefits.contract_benefits.benefit_enrollment_window_ends_at is 'The date the benefit is no longer available to enroll or make changes in.';

comment on column benefits.contract_benefits.first_billing_date is 'The date when the employee benefit billing will first commence.';

comment on column benefits.contract_benefits.rejection_reason is 'The reason why the benefit was rejected';

comment on column benefits.contract_benefits.old_id is 'The old id of the contract benefit.';

comment on column benefits.contract_benefits.deleted_at is 'The date when the contract benefit was deleted.';

comment on column benefits.contract_benefits.cover_all is 'Flag indicating if benefit will fully cover the employee';

comment on column benefits.contract_benefits.cover_dependents is 'Flag indicating if benefit will cover dependents';

comment on column benefits.contract_benefits.number_of_dependents is 'Number of dependents registered on this benefit';

comment on column benefits.contract_benefits.offered_by_client is 'Flag indicating if benefit was offered by client';

comment on column benefits.contract_benefits.registration_number is 'Benefit registration identifier used by the provider';

comment on column benefits.contract_benefits.expiration_date is 'The date in which the contract attached to this benefit is terminated. Thus, this date represents when the benefit will expire.';

comment on column benefits.contract_benefits.offered_through_oe_id is 'The open enrollment through which the benefit was offered.';

comment on column benefits.contract_benefits.offered_through_qle_id is 'The qualifying life event through which the benefit was offered.';

comment on column benefits.contract_benefits.coverage_start_date is 'The date when the employee coverage first starts.';

comment on column benefits.contract_benefits.allow_plan_selection is 'Whether the employee is allowed to select a different plan than the one initially offered.';

comment on column benefits.contract_benefits.coverage_ended_at is 'The date since the employee can no longer use their benefit.';

comment on column benefits.contract_benefits.billing_ended_at is 'The date since we stopped billing money to employees.';

create table if not exists benefits.contract_benefit_dependents
(
    id                  uuid                     not null
        primary key,
    dependent_id        uuid                     not null
        references benefits.benefit_dependents,
    contract_benefit_id uuid                     not null
        references benefits.contract_benefits,
    created_at          timestamp with time zone not null,
    updated_at          timestamp with time zone not null,
    coverage_start_date timestamp with time zone,
    enrolled_date       timestamp with time zone,
    coverage_ended_at   timestamp with time zone
);

comment on table benefits.contract_benefit_dependents is 'This table associates ContractBenefits with its dependents.';

comment on column benefits.contract_benefit_dependents.id is 'ContractBenefitDependent id.';

comment on column benefits.contract_benefit_dependents.dependent_id is 'Employee dependent ID.';

comment on column benefits.contract_benefit_dependents.contract_benefit_id is 'The ContractBenefit this dependent is assigned to.';

comment on column benefits.contract_benefit_dependents.coverage_start_date is 'The date when the dependent coverage will first commence.';

comment on column benefits.contract_benefit_dependents.enrolled_date is 'The date when the dependent was added to the benefit.';

comment on column benefits.contract_benefit_dependents.coverage_ended_at is 'The date since the dependent can no longer use their benefit.';

create unique index if not exists ba_contract_benefit_dependents_unique_dependent_per_benefit_ind
    on benefits.contract_benefit_dependents (dependent_id, contract_benefit_id);

create table if not exists benefits.contract_benefit_offerings
(
    id                     uuid                                   not null
        primary key,
    ba_contract_benefit_id uuid                                   not null
        references benefits.contract_benefits,
    provider_id            uuid
        references benefits.benefit_providers,
    plan_id                uuid
        references benefits.benefit_provider_plans,
    contribution_total     numeric(10, 2)                         not null,
    ended_at               date,
    created_at             timestamp with time zone default now() not null,
    updated_at             timestamp with time zone default now() not null,
    deleted_at             timestamp with time zone
);

comment on table benefits.contract_benefit_offerings is 'The offerings for a contract benefit';

comment on column benefits.contract_benefit_offerings.ba_contract_benefit_id is 'The contract benefit this offering is for';

comment on column benefits.contract_benefit_offerings.provider_id is 'The provider offered for the benefit';

comment on column benefits.contract_benefit_offerings.plan_id is 'The plan offered for the benefit';

comment on column benefits.contract_benefit_offerings.contribution_total is 'The total contribution for the benefit';

comment on column benefits.contract_benefit_offerings.ended_at is 'Date since the offer was removed/ended.';

comment on column benefits.contract_benefit_offerings.deleted_at is 'Date when benefit offering was soft deleted';

create unique index if not exists ba_contract_benefit_offerings_unique_index
    on benefits.contract_benefit_offerings (ba_contract_benefit_id);

create table if not exists benefits.contract_benefit_recurring_items
(
    id                                  uuid                                                                                                               not null
        primary key,
    start_at                            timestamp with time zone                                                                                           not null,
    end_at                              timestamp with time zone,
    deductible_amount_per_payroll_cycle numeric(12, 2)                                                                                                     not null,
    ba_contract_benefit_id              uuid                                                                                                               not null
        references benefits.contract_benefits,
    employee_recurring_item_id          varchar(32)
        constraint ba_contract_benefit_recurring_i_employee_recurring_item_id_fkey
            references employment.employee_recurring_items,
    employment_id                       varchar(32)                                                                                                        not null
        references employment.employments,
    created_at                          timestamp with time zone                                                                                           not null,
    updated_at                          timestamp with time zone                                                                                           not null,
    status                              benefits.enum_contract_benefit_recurring_items_status default 'PENDING'::benefits.enum_contract_benefit_recurring_items_status not null
);

comment on table benefits.contract_benefit_recurring_items is 'This table associates benefits recurring items with contract benefits and the actual employee payroll recurrent item.';

comment on column benefits.contract_benefit_recurring_items.id is 'ContractBenefitRecurrentItem id.';

comment on column benefits.contract_benefit_recurring_items.start_at is 'Date since when the recurring benefit item has to be deducted.';

comment on column benefits.contract_benefit_recurring_items.end_at is 'Date since the benefit recurring item has to stop being deducted.';

comment on column benefits.contract_benefit_recurring_items.deductible_amount_per_payroll_cycle is 'The amount to deduct per payroll cycle.';

comment on column benefits.contract_benefit_recurring_items.ba_contract_benefit_id is 'The benefit contract associated to this item.';

comment on column benefits.contract_benefit_recurring_items.employee_recurring_item_id is 'The employee recurrent item that was created for this benefit deduction.';

comment on column benefits.contract_benefit_recurring_items.employment_id is 'The employement this recurring item is associated with.';

comment on column benefits.contract_benefit_recurring_items.status is 'ContractBenefitRecurringItem status.';

create index if not exists recurring_items_contract_benefit_id_index
    on benefits.contract_benefit_recurring_items (ba_contract_benefit_id);

create index if not exists recurring_items_status_and_end_at_index
    on benefits.contract_benefit_recurring_items (status, end_at);

create index if not exists recurring_items_status_and_start_at_index
    on benefits.contract_benefit_recurring_items (status, start_at);

create index if not exists ba_contract_benefits_contract_id_index
    on benefits.contract_benefits (contract_id);

create index if not exists ba_contract_benefits_offered_through_oe_id_idx
    on benefits.contract_benefits (offered_through_oe_id);

create index if not exists ba_contract_benefits_offered_through_qle_id_idx
    on benefits.contract_benefits (offered_through_qle_id);

create index if not exists ba_contract_benefits_selected_benefit_provider_id_index
    on benefits.contract_benefits (selected_benefit_provider_id);

create index if not exists ba_contract_benefits_selected_benefit_provider_plan_id_index
    on benefits.contract_benefits (selected_benefit_provider_plan_id);

create index if not exists ba_qualifying_life_events_create_at_index
    on benefits.qualifying_life_events (created_at);

create index if not exists ba_qualifying_life_events_reviewed_by_index
    on benefits.qualifying_life_events (reviewed_by);

create index if not exists ba_qualifying_life_events_status_index
    on benefits.qualifying_life_events (status);

create index if not exists ba_qualifying_life_events_uploaded_by_index
    on benefits.qualifying_life_events (uploaded_by);

