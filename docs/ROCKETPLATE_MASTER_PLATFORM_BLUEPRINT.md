# ROCKETPLATE MASTER PLATFORM + IMMERSIVE WEBSITE BUILD BLUEPRINT

**Document type:** Product requirements, operating system, launch plan, and Claude build prompt pack  
**Version:** 4.0  
**Date:** July 21, 2026  
**Owner:** Andre “Dre” Pelissier  
**Project:** RocketPlate  
**Status:** Primary source of truth for the public website, subscriber platform, restaurant platform, delivery operations, master dashboard, automation system, and immersive 3D experience

---

## 0. PURPOSE OF THIS DOCUMENT

This document consolidates the agreed RocketPlate business model, public website, account types, waitlist, Founding Crew signup, subscriber dashboard, restaurant onboarding and approval system, restaurant dashboard, master administration dashboard, delivery and labeling system, autonomous operating model, 3D storytelling experience, implementation sequence, testing requirements, and Claude prompt set.

It is written to be loaded into Claude/Fable as governing project context before the model audits, designs, changes, or deploys the RocketPlate platform.

### Priority rules

1. Audit and preserve working code before redesigning anything.
2. Build one connected platform, not disconnected landing pages and prototypes.
3. Use real data from Supabase. Never show fabricated customer, restaurant, route, revenue, or launch numbers.
4. Never charge a Founding Crew member without the required notices and a verified launch state.
5. Never expose an unapproved restaurant or meal to customers.
6. Never imply a restaurant partnership until a signed agreement or written approval exists.
7. Keep pricing, service areas, schedules, meal standards, promotions, capacity, and launch dates configurable.
8. Public forms, dashboards, emails, Stripe events, and analytics must be tested end to end.
9. Use immersive media to create wonder, but keep pricing, consent, forms, support, and legal information in accessible live HTML.
10. Functionality and trust come before visual polish. Visual polish must not delay a safe lead-capture launch.

---

# 1. ROCKETPLATE IN ONE SENTENCE

RocketPlate is a recurring hot-dinner subscription that coordinates local independent restaurants during their slow 2:00–4:00 PM production window and delivers complete restaurant meals to subscribers in one efficient evening delivery window.

RocketPlate is not:

- A meal kit
- A ghost kitchen
- A chilled weekly meal-prep box
- A general on-demand delivery marketplace
- A white-label restaurant delivery app
- A platform that replaces chefs or restaurants

RocketPlate owns the customer relationship, subscription, service-area demand, delivery experience, restaurant partner relationship, brand, operations data, and quality standards.

---

# 2. CURRENT PILOT MODEL

## 2.1 Initial launch market

- Miami-Dade County
- Initial focus: Kendall and nearby approved ZIP codes
- Initial operating radius: tightly controlled and configurable
- Initial target: 50–100 subscribers
- Initial restaurant group: approximately 3–5 independent owner-operated restaurants
- Pilot validation window: approximately 60 days
- Restaurants must remain unnamed publicly until approved and contractually cleared

## 2.2 Daily operating rhythm

| Time | Event |
|---|---|
| 8:00 PM prior evening | Automated meal-selection or change reminder |
| 9:00 PM prior evening | Standard meal-change cutoff |
| 10:00 PM prior evening | Initial finalized production counts sent to restaurants |
| 1:00 PM delivery day | Same-day add-on cutoff and final count adjustment |
| 2:00–4:00 PM | Restaurant batch production during slow hours |
| 4:00–4:45 PM | Quality check, labeling, bagging, staging, and driver pickup |
| 5:00–7:00 PM | Focused customer delivery window |
| After route | Delivery reconciliation, exception handling, ratings, and payout records |

All time windows must be configurable by service area, delivery day, and restaurant.

## 2.3 Current plan pricing

### 5-Day Mission

- **$89.99 per week**
- Five individual restaurant dinners
- Effective revenue: approximately **$18.00 per meal**

### 7-Day Mission

- **$129.99 per week**
- Seven individual restaurant dinners
- Effective revenue: approximately **$18.57 per meal**

### Family Mission

- Required as a visible future tier
- Final sustainable price is **not approved**
- Do not accept a paid Family Mission subscription until economics, packaging, restaurant payouts, and serving standards are validated
- The website may allow visitors to join a Family Mission interest list

### Pricing warning

The 7-Day Mission currently costs slightly more per meal than the 5-Day Mission. Do not claim that the 7-Day Mission “saves more” unless pricing or benefits change. Its value proposition must come from convenience or additional benefits, or the price must later be adjusted.

## 2.4 Founding Crew offer

The Founding Crew program should support the previously discussed Founding 100 structure:

- Limited founding positions
- First week free
- 33% off the second month
- Current plan price locked for 12 continuous months
- Founding member number
- Digital Founding Crew badge
- Priority launch access
- Priority meal-selection windows where capacity is limited
- Priority support during the pilot
- Referral recognition and configurable rewards
- Eligibility for a future limited collectible or RocketPlate mascot giveaway
- Early feedback council access
- Possible partner tasting or launch-event invitations

The promotion engine must make every benefit configurable. Never promise a lifetime rate. “Locked-in price” means the disclosed bounded term, currently 12 continuous months, unless the founder later changes it.

---

# 3. RELEASE STRATEGY: READY FOR ALL VISITORS TONIGHT

RocketPlate must use three release gates.

## Gate A — Public Discovery and Lead Capture

This gate can go live first and must support every visitor type truthfully.

Required:

- Public immersive homepage
- Clear explanation of RocketPlate
- Service-area ZIP check
- Free waitlist/Explorer signup
- Founding Crew reservation with Stripe card-on-file and no immediate charge
- Restaurant information page
- Restaurant application for eligible areas
- Restaurant waitlist for future areas
- Account creation and login
- Contact, FAQ, privacy, terms, subscription disclosures, cancellation disclosures, and support path
- Branded confirmation emails
- Real Supabase records
- Admin visibility
- Analytics
- Mobile responsiveness
- Accessible fallback for the 3D experience

## Gate B — Controlled Pilot Operations

Required before real meal fulfillment:

- Approved restaurant accounts
- Restaurant onboarding checklist
- Menu submission and approval
- Meal standards
- Production counts
- Label and packing manifests
- Delivery routes
- Driver scan flow
- Customer meal selection
- Operational alerts
- Restaurant communications
- Exception handling
- Payout tracking
- Customer support workflows
- End-to-end launch simulation

## Gate C — Paid Subscription Activation

Real billing must remain disabled behind a feature flag until all billing safeguards pass.

Required:

- Valid Stripe production configuration
- SetupIntent card collection
- Explicit consent to future billing
- Confirmed service-area launch date
- 72-hour notice
- 48-hour notice
- 24-hour notice
- Cancellation and payment-update links
- Charge amount disclosed
- Subscription terms accepted
- Notification delivery records
- Stripe webhook verification
- Duplicate-charge protection
- Failed-payment handling
- Admin billing audit view
- Test-mode acceptance tests
- Production smoke test with an authorized internal test account

No model, agent, admin shortcut, or launch announcement may bypass the billing gate without an audited manual override.

---

# 4. USERS, ACCOUNTS, AND PERMISSIONS

## 4.1 Public visitor

Can:

- View the site
- Play or skip the cinematic intro
- Read how RocketPlate works
- Check ZIP availability
- View plans
- Join the free waitlist
- Reserve Founding Crew
- View restaurant partner information
- Apply as a restaurant
- Join the restaurant waitlist
- Contact support

## 4.2 Explorer / free waitlist member

A free lead with no payment method required.

Minimum required fields:

- Full name
- Valid email
- ZIP code
- Optional phone number

Optional progressive-profile fields:

- Household size
- Preferred plan
- Favorite cuisines
- Dietary preferences
- Preferred delivery days
- Referral source
- Referral code
- Marketing consent
- SMS consent, separate from email consent

Explorer members receive:

- Confirmation email
- Service-area progress updates
- Launch notification
- Referral link
- Ability to upgrade to Founding Crew
- No charge and no card requirement

## 4.3 Founding Crew member

A high-intent early member with:

- User account
- Verified email
- Eligible ZIP or selected future service area
- Stripe Customer record
- Valid payment method saved through Stripe SetupIntent
- Explicit future-charge consent
- Accepted Founding Crew terms
- Founding number
- Promotion assignment
- No active charge until the launch and notice requirements pass

## 4.4 Active subscriber

Can use the full subscriber dashboard and receive meals according to the active plan, service area, capacity, and delivery schedule.

## 4.5 Restaurant applicant

Can:

- Submit an application
- Track application status through a limited portal
- Respond to requests for information
- Upload required documents
- Not access production functions until approved

## 4.6 Approved restaurant partner

Can access restaurant onboarding, menu management, production, labeling, communications, performance, and payout tools.

## 4.7 Driver / delivery contractor

Can access only assigned delivery operations:

- Assigned routes
- Pickup manifests
- Scan-in
- Stop sequence
- Delivery instructions
- Proof of delivery
- Exception reporting

Drivers must not see unnecessary payment, marketing, or restaurant financial data.

## 4.8 Administrative roles

Use role-based access control.

- Founder / Super Admin
- Operations Admin
- Restaurant Success
- Customer Support
- Finance
- Marketing / Growth
- Dispatch Manager
- Menu and Quality Reviewer
- Read-Only Analyst

Every sensitive action must be permission-checked and logged.

---

# 5. ONE CONNECTED PLATFORM

Use one primary codebase and one Supabase source of truth.

The application may respond to multiple domains, but it must not become separate disconnected products. Domain redirects and canonical-domain decisions must be audited before changes are made.

## Recommended route map

### Public

- `/`
- `/how-it-works`
- `/plans`
- `/founding-crew`
- `/waitlist`
- `/service-area`
- `/restaurants`
- `/restaurants/apply`
- `/restaurants/waitlist`
- `/family`
- `/about`
- `/faq`
- `/contact`
- `/privacy`
- `/terms`
- `/subscription-terms`
- `/cancellation`
- `/refunds`
- `/promotion-terms`
- `/restaurant-terms`
- `/accessibility`

### Authentication

- `/login`
- `/signup`
- `/verify-email`
- `/forgot-password`
- `/reset-password`

### Subscriber

- `/account`
- `/account/mission`
- `/account/meals`
- `/account/deliveries`
- `/account/billing`
- `/account/referrals`
- `/account/notifications`
- `/account/support`
- `/account/settings`

### Restaurant

- `/partner`
- `/partner/onboarding`
- `/partner/profile`
- `/partner/menu`
- `/partner/menu/new`
- `/partner/production`
- `/partner/labels`
- `/partner/pickups`
- `/partner/payouts`
- `/partner/performance`
- `/partner/messages`
- `/partner/standards`
- `/partner/support`

### Driver

- `/driver`
- `/driver/routes`
- `/driver/route/[id]`
- `/driver/exceptions`

### Master administration

- `/admin`
- `/admin/customers`
- `/admin/waitlist`
- `/admin/founding-crew`
- `/admin/restaurants`
- `/admin/restaurants/applications`
- `/admin/restaurants/menus`
- `/admin/quality`
- `/admin/production`
- `/admin/dispatch`
- `/admin/routes`
- `/admin/labels`
- `/admin/orders`
- `/admin/billing`
- `/admin/payouts`
- `/admin/promotions`
- `/admin/economics`
- `/admin/service-areas`
- `/admin/expansion`
- `/admin/support`
- `/admin/content`
- `/admin/analytics`
- `/admin/system-health`
- `/admin/audit-log`
- `/admin/configuration`

---

# 6. PUBLIC WEBSITE EXPERIENCE

## 6.1 Visitor decision logic

The primary conversion flow begins with a ZIP check.

### Served area

Show:

- Active or scheduled launch status
- Available plans
- Founding Crew status
- Delivery days and window
- Capacity status
- Signup CTA

### Near or upcoming area

Show:

- Expected status without inventing a date
- Free waitlist
- Founding Crew reservation only if operationally and legally approved for that area
- Referral system
- Honest launch-threshold progress if based on real data

### Unsupported area

Show:

- Free waitlist
- Area demand message
- Referral link
- No false promise of a date

## 6.2 Required homepage sections

1. Cinematic mission signal
2. Immediate plain-language explanation
3. Service-area ZIP check
4. How RocketPlate works
5. Real approved food photography
6. Local restaurant value
7. Plans
8. Explorer waitlist
9. Founding Crew
10. Quality and meal standards
11. Focused delivery model
12. Trust and transparency
13. Restaurant partner CTA
14. FAQ
15. Final mission-control CTA
16. Footer and legal links

## 6.3 Conversion principles

At every point, visitors must understand:

- What RocketPlate is
- Where it is launching
- What they receive
- What it costs
- Whether they are being charged
- How the free waitlist differs from Founding Crew
- What happens after signup
- How to cancel before a future charge
- Who prepares the food
- How meals are standardized
- How delivery works

---

# 7. FREE WAITLIST / EXPLORER SYSTEM

## 7.1 Required fields

- Full name
- Email
- ZIP code
- Phone number, optional

## 7.2 Validation

- Valid email format
- ZIP format validation
- Phone normalization only when provided
- Duplicate email handling
- Duplicate email plus ZIP updates the existing record rather than creating uncontrolled duplicates
- Bot and spam protection
- Rate limiting
- Clear consent checkboxes
- Transactional and marketing consent stored separately

## 7.3 Optional fields

- Household size
- Number of desired weekly meals
- Cuisine interests
- Dietary preferences
- Preferred delivery days
- Family-plan interest
- Referral source
- Referral code

## 7.4 After signup

- Save to Supabase
- Assign service-area or demand-zone record
- Send branded confirmation
- Create unique referral link
- Show a clear success state
- Track the conversion event
- Notify the user when the area launches
- Make the record visible in the admin dashboard
- Update the geographic demand model
- Never claim a fake position or fake number

---

# 8. FOUNDING CREW SIGNUP AND BILLING SAFETY

## 8.1 Required signup information

- Full legal or billing name
- Email
- ZIP code
- Service address when the area is eligible
- Optional phone number
- Selected plan
- Stripe payment method
- Explicit future-billing consent
- Subscription terms acceptance
- Founding Crew terms acceptance
- Communication consent
- Referral source
- Account password or passwordless account setup

## 8.2 Card collection

Use Stripe:

- Create or reuse Stripe Customer
- Create SetupIntent
- Collect payment method in Stripe-hosted or Stripe Elements flow
- Never store raw card numbers, CVC, or full payment details
- Store only Stripe identifiers and safe display metadata
- Confirm SetupIntent success
- Show “card saved, not charged” clearly
- Send payment-method-saved email

## 8.3 Founding status states

- `started`
- `payment_pending`
- `payment_method_saved`
- `reserved`
- `launch_date_scheduled`
- `notice_72_sent`
- `notice_48_sent`
- `notice_24_sent`
- `ready_for_activation`
- `active`
- `payment_failed`
- `canceled_before_launch`
- `paused`
- `expired`

## 8.4 Required pre-charge sequence

When an area is approved for launch and the member has an activation date:

### 72 hours before

Send email and, only with consent, SMS containing:

- Exact launch date
- Exact planned first charge date
- Exact amount
- Selected plan
- Promotion being applied
- Delivery window
- Cancellation link
- Payment-update link
- Support link

### 48 hours before

Send a second reminder with the same critical information.

### 24 hours before

Send a final reminder with the same critical information and a prominent cancellation path.

### Charge gate

The system must not activate or charge unless:

- Service area is active
- Launch date is confirmed
- Selected plan is active
- Capacity exists
- Payment method remains valid
- Terms version is current
- Future-charge consent is recorded
- 72-hour notice record exists
- 48-hour notice record exists
- 24-hour notice record exists
- User has not canceled
- Billing feature flag is enabled
- Stripe webhook health is passing
- Duplicate subscription protection passes

If a launch date changes, cancel the old scheduled activation, disclose the change, and restart the required notice sequence.

## 8.5 Founding Crew dashboard before launch

Show:

- Founding member number
- Founding benefits
- Selected plan
- Card saved status
- “You have not been charged”
- Area status
- Launch date when confirmed
- Scheduled charge date and amount
- Notification timeline
- Update payment method
- Cancel reservation
- Referral link
- Support

---

# 9. SUBSCRIBER DASHBOARD

The subscriber dashboard should feel like a simple mission-control center, not an enterprise admin screen.

## 9.1 Overview

- Current plan
- Account status
- Service-area status
- Next delivery date
- Delivery window
- Next billing date
- Next charge amount
- Active promotion
- Founding Crew status
- Important alerts
- Meal-selection deadline
- Current mission progress

## 9.2 Meal selection

- Approved meals only
- Real food images
- Restaurant shown only after partnership approval
- Dish name and description
- Entrée and sides
- Ingredients
- Allergens
- Dietary tags
- Reheating or serving notes
- Availability
- Remaining capacity
- Selection deadline
- Swap rules
- Upgrade price where applicable
- Save and confirmation state

## 9.3 Deliveries

- Upcoming deliveries
- Delivery date and window
- Status timeline
- Restaurant source
- Selected meals
- Delivery address
- Delivery instructions
- Route status without exposing other customers
- Driver arrival notification where available
- Proof of delivery
- Report an issue
- Rate meal and delivery

## 9.4 Billing

- Current plan
- Payment method
- Billing history
- Promotion history
- Upcoming charge
- Update payment method through Stripe
- Change plan
- Pause
- Cancel
- Reactivate
- Download receipt where supported

## 9.5 Referrals

- Unique link
- Unique code
- Qualified referral count
- Pending rewards
- Earned rewards
- Terms
- Fraud protection

## 9.6 Profile and settings

- Name
- Email
- Phone
- Delivery address
- Delivery instructions
- Dietary preferences
- Allergen information
- Notification preferences
- Password or authentication controls
- Privacy request
- Account deletion request
- Support history

---

# 10. RESTAURANT PARTNER ACQUISITION

The restaurant experience should follow proven SaaS marketplace onboarding patterns: clear value, eligibility, structured application, document collection, review, onboarding, activation, and continuous partner success.

Do not copy another company’s proprietary design. Use the operational discipline seen in platforms such as Groupon, DoorDash merchant onboarding, Toast, Shopify, and other small-business SaaS systems.

## 10.1 Restaurant discovery page

Explain:

- What RocketPlate is
- How slow-hour production creates incremental revenue
- How subscriber counts are planned in advance
- How RocketPlate handles the customer subscription and delivery relationship
- Pilot structure
- Service-area rules
- Restaurant responsibilities
- RocketPlate responsibilities
- Menu standards
- Packaging expectations
- Production and pickup windows
- Payout process
- Quality expectations
- What information is required
- What happens after applying
- Applying does not guarantee approval

## 10.2 Restaurant eligibility check

Capture:

- Restaurant name
- Address
- ZIP code
- Contact person
- Email
- Phone
- Cuisine

Classify:

- Active pilot zone
- Near active zone
- Future high-demand zone
- Outside current expansion priority

## 10.3 Active-zone application

Capture:

### Business identity

- Legal business name
- DBA
- Restaurant name
- Business address
- ZIP
- Website
- Social profiles
- Ownership or operator details
- Primary contact
- Email
- Phone

### Operations

- Cuisine type
- Hours
- Number of locations
- Existing pickup or delivery capability
- Kitchen capacity between 2:00–4:00 PM
- Estimated maximum RocketPlate meals per day
- Current packaging capability
- POS system
- Preferred onboarding date
- Current delivery radius
- Menu readiness

### Compliance and commercial setup

- Food-service license or permit information as appropriate
- Food-safety acknowledgment
- Insurance information as appropriate
- Tax and payout information through secure providers
- Agreement to pilot standards
- Agreement to quality checks
- Agreement to production windows
- Agreement to RocketPlate approval rights
- Agreement not to substitute ingredients without updating required information
- Agreement to notify RocketPlate of shortages or closures

### Application result

- Save record
- Send branded confirmation
- Create CRM record
- Assign status
- Notify admin
- Provide next steps
- Do not give full partner access before approval

## 10.4 Restaurant waitlist

Capture:

- Restaurant name
- Address
- ZIP
- Cuisine
- Owner or operator
- Email
- Phone
- Capacity
- Menu readiness
- Interest level
- Preferred timing
- Current delivery radius
- Notes
- Consent to updates

After submission:

- Confirmation email
- CRM record
- Geographic supply record
- Expansion score
- Future outreach queue
- Notify when the area opens

---

# 11. RESTAURANT APPROVAL SYSTEM

## 11.1 Approval pipeline

- `lead`
- `contacted`
- `interested`
- `application_started`
- `application_submitted`
- `under_review`
- `information_requested`
- `conditionally_approved`
- `approved`
- `onboarding`
- `menu_review`
- `production_test`
- `active`
- `waitlisted`
- `paused`
- `declined`
- `archived`

## 11.2 AI Partner Review Agent

Create an AI agent that recommends approval, conditional approval, waitlist, request for more information, or decline.

The AI agent must produce:

- Overall score
- Score by criterion
- Evidence used
- Missing information
- Risks
- Required changes
- Recommended next action
- Confidence level
- Human-readable explanation
- Audit record

The AI agent must not silently activate or permanently reject a restaurant. Final activation requires an authorized admin or a strictly defined policy-based auto-approval gate with audit logs.

## 11.3 Recommended scoring criteria

| Category | Example weight |
|---|---:|
| Service-area fit | 15% |
| Kitchen capacity and reliability | 15% |
| Menu compatibility and portion value | 15% |
| Food-safety and documentation readiness | 15% |
| Review quality, volume, and recency | 10% |
| Local popularity and demand evidence | 10% |
| Cuisine gap or strategic fit | 10% |
| Packaging and pickup readiness | 5% |
| Responsiveness and onboarding completion | 5% |

Weights must be configurable.

## 11.4 Review and popularity analysis

Use public reviews and popularity as one factor, not the sole decision.

The agent should consider:

- Average rating
- Number of reviews
- Review recency
- Review consistency
- Repeated quality complaints
- Repeated service complaints
- Known signature dishes
- Local social engagement
- Search interest where legally and technically available
- Demand for the cuisine in the target ZIP
- Restaurant age and operating history
- New restaurants with insufficient review history

Do not automatically penalize a new restaurant solely for having fewer reviews. Give new restaurants a manual trial or conditional approval path.

Do not scrape or use data in violation of provider terms. Store evidence source, date, and confidence.

---

# 12. RESTAURANT ONBOARDING CHECKLIST

After approval, the restaurant receives a secure portal and checklist.

## Required onboarding tasks

1. Verify account and contacts
2. Complete restaurant profile
3. Sign required agreements
4. Complete payout setup
5. Confirm production days
6. Confirm 2:00–4:00 PM capacity
7. Confirm pickup window
8. Review RocketPlate meal standards
9. Review food-photo standards
10. Review packaging and label standards
11. Upload initial menu items
12. Resolve AI or admin revision requests
13. Complete a production and packout test
14. Complete label scan test
15. Confirm emergency contact
16. Confirm closure and shortage procedures
17. Receive activation approval

The partner dashboard must show percentage complete, blocked items, owner, due date, and next action.

---

# 13. RESTAURANT MENU SYSTEM

## 13.1 Menu limits

- Pilot target: up to six approved menu items per restaurant
- Minimum recommended launch selection: three
- Limit must be configurable
- Only approved and currently available items appear to customers

## 13.2 Required menu-item fields

- Dish name
- Customer-facing description
- Cuisine
- Entrée or main component
- Side components
- Finished serving size or weight
- Ingredients
- Major allergens
- Dietary tags
- Preparation method
- Required packaging
- Hold-time guidance
- Reheating or serving instructions
- Requested restaurant payout
- Estimated food cost
- Daily capacity
- Available days
- Cutoff rules
- Substitution policy
- Hero image
- Optional detail images
- Restaurant internal SKU
- RocketPlate SKU
- Approval status
- Revision history

## 13.3 Menu approval states

- `draft`
- `submitted`
- `missing_information`
- `photo_failed`
- `standards_failed`
- `economics_failed`
- `ai_recommended_approve`
- `ai_recommended_revision`
- `ai_recommended_decline`
- `human_approved`
- `active`
- `paused`
- `seasonal`
- `archived`

## 13.4 AI Menu Approval Agent

The agent evaluates:

- Complete entrée-plus-sides structure
- Satisfactory serving size
- Customer value
- Requested payout and contribution margin
- Suitability for batch cooking
- Ability to hold safely and remain attractive during delivery
- Packaging compatibility
- Ingredient completeness
- Allergen completeness
- Dietary-label accuracy
- Photo compliance
- Menu duplication
- Restaurant capacity
- Popularity and review evidence
- Cuisine demand
- Customer rating history after launch

The result must provide specific revision instructions, not a generic rejection.

Examples:

- Increase vegetable side to meet serving standard
- Replace packaging because sauce leakage risk is high
- Upload a brighter image with the full meal visible
- Clarify whether the sauce contains dairy
- Reduce requested payout or revise components
- Limit daily capacity until the production test passes

---

# 14. MEAL SIZE, QUALITY, AND CONSISTENCY STANDARD

RocketPlate must provide a complete restaurant dinner, not a snack-sized plate.

The following are configurable pilot defaults and must be validated with restaurant partners. They are not nutritional or legal claims.

## 14.1 Standard individual meal target

- Total edible meal target: approximately 18–24 ounces
- Cooked protein or primary entrée: approximately 5–7 ounces
- Substantial vegetarian main: approximately 8–10 ounces where applicable
- Starch, grain, pasta, or substantial base: approximately 6–8 ounces
- Vegetable, salad, or approved side: approximately 4–6 ounces
- Sauce or accompaniment: approximately 1–2 ounces as appropriate

Cuisine-specific equivalents are allowed when the total meal remains complete and satisfying.

## 14.2 Meal structure

Every standard meal should include:

- One substantial entrée or main
- One substantial base or primary side
- One vegetable, salad, or second approved side
- Appropriate sauce, garnish, or accompaniment
- Required allergen and dietary information
- Tamper-evident packaging
- Clear meal identity and customer label

## 14.3 Quality-control system

- Approved recipe or build card
- Portion standard
- Reference photo
- Required packaging
- Batch capacity
- Random portion checks
- Restaurant self-check before pickup
- RocketPlate pickup scan
- Customer rating
- Issue and refund reason tracking
- Rolling restaurant and item quality score
- Automatic review queue when thresholds are missed
- Immediate pause option for food-safety or repeated severe-quality issues

Suggested configurable triggers:

- Repeated low portion ratings
- Repeated leakage
- Repeated missing items
- Late pickup readiness
- Customer rating below a configured threshold
- High refund rate
- Allergen-data mismatch
- Unauthorized substitution
- Production quantity variance

---

# 15. FOOD PHOTO STANDARD

The photo system must make restaurant onboarding fast while producing consistent, trustworthy food cards.

## 15.1 Required photo set

- One required hero image
- Up to two optional detail images
- A reference portion image may be required for quality control

## 15.2 Hero photo requirements

- Entire meal visible
- Clear, uncluttered background
- Neutral or brand-approved surface
- Accurate food color
- Soft natural or diffused lighting
- Sharp focus on the meal
- No people, hands, utensils in motion, receipts, kitchen clutter, or unrelated objects
- No text, menu prices, watermarks, promotional badges, or third-party logos
- No excessive filters
- No deceptive AI additions or portion enlargement
- No component cropped out
- The image must match the actual meal and approved portion

## 15.3 File standards

Recommended upload master:

- Aspect ratio: 4:3
- Preferred: 2000 × 1500 pixels or larger
- Minimum: 1200 × 900 pixels
- Color space: sRGB
- Formats: JPG, PNG, or WebP
- Maximum upload size: configurable, recommended 8 MB
- No HEIC as the only stored production format; convert on upload

System-generated derivatives:

- 1600 × 1200, 4:3 meal card
- 1200 × 1200, square
- 1600 × 900, 16:9 marketing crop
- Mobile-optimized WebP/AVIF where supported

## 15.4 Automated photo checks

The AI photo agent should detect:

- Low resolution
- Blur
- Poor exposure
- Cluttered background
- Food cropped out
- Multiple unrelated dishes
- Text or watermark
- Heavy filtering
- Inconsistent portion versus reference
- Wrong aspect ratio
- Duplicate image
- Potential stock image
- Potential AI-generated misrepresentation

The agent can remove or simplify a background only when the meal remains accurate. The original must be preserved.

---

# 16. RESTAURANT PARTNER DASHBOARD

## 16.1 Home

- Approval status
- Onboarding completion
- Today’s production status
- Upcoming production days
- Meal counts
- Pickup window
- Alerts
- Menu revisions
- Payout status
- Support messages

## 16.2 Restaurant profile

- Business information
- Contacts
- Hours
- Service location
- Kitchen capacity
- Documents
- Agreement status
- Payout status
- Emergency contact

## 16.3 Menu manager

- Add item
- Edit item
- Upload photos
- Enter portion, ingredients, and allergens
- Set capacity
- Set days
- Submit for AI review
- View score and approval status
- Receive revision notes
- Resubmit
- Pause item
- View customer feedback

## 16.4 Production center

- Final counts by item
- Preliminary count
- Final count
- Add-on adjustment
- Required completion time
- Packaging count
- Labels
- Customer exception notes
- Allergen flags
- Shortage reporting
- Substitute-request workflow
- “Ready for pickup” action
- Pickup scan

## 16.5 Label and packout center

- Print meal labels
- Print bag labels
- Print production sheet
- Print packing manifest
- View route staging plan
- Scan meal into bag
- Scan bag into route
- Report label reprint
- Report missing item

## 16.6 Payouts

- Meals accepted
- Adjustments
- Restaurant payout
- Staff incentive where applicable
- Refund deductions according to policy
- Payout schedule
- Payout status
- Downloadable statement

## 16.7 Performance

- On-time readiness
- Production accuracy
- Meal ratings
- Portion ratings
- Packaging issues
- Refund rate
- Repeat selection rate
- Capacity utilization
- Menu-item performance
- Actionable improvement suggestions

---

# 17. LOW-COST DELIVERY, LABELING, AND STAGING SYSTEM

RocketPlate should begin with a thin proprietary control layer rather than building a full enterprise fleet platform before the pilot.

## 17.1 Recommended pilot stack

- Supabase: source of truth
- Next.js/Vercel: web platform
- Stripe: billing
- Resend: email
- Twilio: consented operational SMS
- n8n or Make: workflow orchestration
- Routific or a comparable route optimizer: route sequencing during the pilot
- Google Maps or compatible mapping for navigation
- Mobile web/PWA driver interface
- Standard thermal printers
- QR codes and scan events

RocketPlate retains the customer relationship, branded notifications, data, support, and delivery control. A route-optimization engine may be used as infrastructure without handing the customer relationship to a white-label marketplace.

## 17.2 Label types

### Meal label

Recommended size: 2 × 1 inches or similar.

Contains:

- RocketPlate meal SKU
- Dish short name
- Restaurant code
- Production date
- Dietary tags
- Allergen alert
- Bag/order code
- QR code
- Optional use-by or handling text as approved

### Outer bag label

Recommended size: 4 × 6 thermal label.

Contains:

- Large route code
- Large stop number
- Bag number, such as 1 of 2
- Customer first name and last initial only
- Short delivery-zone identifier
- Order code
- Restaurant pickup source
- Meal count
- Allergen or handling alert
- QR code
- Driver scan status
- Delivery date and window

Do not print full payment information. Minimize personal information visible on the bag.

## 17.3 QR scan chain

1. Meal produced
2. Meal label printed
3. Meal scanned into customer bag
4. Bag scanned complete
5. Bag scanned to route tote
6. Driver scans route pickup
7. Driver scans or confirms delivery
8. Exception or proof captured
9. Route reconciled

Every scan creates a timestamped event.

## 17.4 Restaurant packing table

Use a simple three-stage table:

### Stage 1 — Production Complete

- Meals grouped by SKU
- Portion and packaging check
- Meal labels applied

### Stage 2 — Customer Packout

- Bags arranged by route and stop
- Meal scanned into bag
- Bag count checked
- Allergen flag checked
- Bag sealed

### Stage 3 — Route Staging

- Reusable tote or rack for each route
- Stop order clearly visible
- Large route code
- Driver scan
- Exception area for unresolved bags

Low-cost visual control:

- Reusable route totes
- Large printed route cards
- Optional colored clips or dot stickers
- Monochrome thermal labels as the primary system
- Phone-camera QR scanning

## 17.5 Required manifests

- Restaurant production sheet
- Item-by-item count sheet
- Customer packout manifest
- Route tote manifest
- Driver route manifest
- Pickup reconciliation
- Delivery exception report
- End-of-day reconciliation report

---

# 18. DELIVERY AND DISPATCH SYSTEM

## 18.1 Dispatch dashboard

Show:

- Active routes
- Drivers
- Restaurants
- Pickup readiness
- Bag counts
- Stop counts
- Route sequence
- Estimated completion
- Late-risk alerts
- Missing scans
- Failed delivery
- Customer support incident
- Map
- Manual reassignment
- Route completion

## 18.2 Driver flow

- Secure login
- Assigned route only
- Restaurant pickup sequence
- Pickup manifest
- Bag scan
- Navigation
- Customer instructions
- Contact masking where possible
- Delivery confirmation
- Photo proof where permitted
- Exception reasons
- Return or disposal instructions
- Route closeout

## 18.3 Exception categories

- Restaurant late
- Meal missing
- Wrong label
- Bag incomplete
- Driver delayed
- Customer unavailable
- Address problem
- Access problem
- Damaged or spilled meal
- Food-quality concern
- Allergen concern
- Route capacity issue
- Vehicle issue
- Weather or emergency

Each category must have a defined escalation and customer communication.

---

# 19. MASTER ADMINISTRATION DASHBOARD

The master dashboard is RocketPlate’s operating command center.

## 19.1 Executive overview

- Active subscribers
- Founding Crew reservations
- Explorer waitlist
- Conversion rate
- Service-area demand
- Restaurant applications
- Approved restaurants
- Active restaurants
- Menu approvals
- Meals scheduled
- Delivery volume
- Route density
- Revenue
- Promotion cost
- Contribution margin estimate
- Failed payments
- Refunds
- Restaurant payouts
- Support issues
- Top ZIP codes
- Cuisine gaps
- Recommended next launch area
- System health
- Recent activity

## 19.2 Customer management

- Search and filters
- Profile
- ZIP and service area
- Waitlist status
- Founding status
- Subscription
- Plan
- Promotion
- Payment status
- Referral activity
- Communication history
- Delivery history
- Support state
- Authorized account actions
- Audit log

## 19.3 Restaurant CRM

- Pipeline stages
- Contact information
- Cuisine
- Location
- Demand near restaurant
- Application
- AI score
- Approval status
- Documents
- Menu status
- Onboarding checklist
- Production performance
- Payout status
- Assigned team member
- Next action
- Follow-up date
- Notes
- Email history
- Tags
- Export

## 19.4 Menu and quality review

- Submission queue
- AI recommendation
- Photo score
- Portion score
- Economics score
- Allergen completeness
- Popularity evidence
- Revision notes
- Human approve or reject
- Activation
- Pause
- Version history
- Customer quality signals

## 19.5 Production control

- Counts by day
- Counts by restaurant
- Counts by item
- Capacity warnings
- Cutoff status
- Count-change history
- Packaging count
- Label generation
- Restaurant acknowledgment
- Pickup readiness
- Exceptions

## 19.6 Delivery control

- Routes
- Drivers
- Stops
- Route density
- Pickup status
- Scan status
- Estimated completion
- Exceptions
- Customer alerts
- Route history

## 19.7 Billing and promotions

- Stripe customer status
- SetupIntent status
- Subscription status
- Launch notice timeline
- Charge gate
- Failed payments
- Refunds
- Promotion setup
- Promotion redemptions
- Locked-rate term
- Founding benefits
- Manual override with reason and audit

## 19.8 Unit-economics simulator

Inputs:

- Restaurant payout per meal
- Kitchen staff incentive
- Packaging
- Label
- Insulated bag allocation
- Delivery route cost
- Delivery cost per stop
- Delivery cost per meal
- Stripe fees
- Refund allowance
- Waste allowance
- Promotion cost
- Customer acquisition cost
- Support cost
- Taxes
- Subscription price
- Meals per plan
- Retention
- Referral cost

Outputs:

- Revenue per meal
- Revenue per subscriber
- Variable cost per meal
- Contribution margin per meal
- Contribution margin percentage
- First-week margin
- First-month margin
- Promotion cost
- Break-even week
- Break-even subscriber count
- Estimated LTV
- LTV:CAC
- Cash required
- Sensitivity to route density
- Sensitivity to restaurant payout
- Sensitivity to price
- Scenario comparison

## 19.9 Service-area and expansion intelligence

- Customer demand by ZIP
- Founding Crew by ZIP
- Restaurant supply by ZIP
- Cuisine coverage
- Household interest
- Route feasibility
- Capacity
- Suggested expansion rank
- Reason for rank
- Threshold alerts
- Demand versus supply
- No fabricated numbers

## 19.10 Configuration center

Authorized admins can change without code:

- Service areas
- ZIP eligibility
- Delivery days
- Delivery windows
- Production windows
- Restaurant capacity
- Subscriber capacity
- Signup limits
- Plans
- Prices
- Promotions
- Founding benefits
- Referral rewards
- Waitlist thresholds
- Menu-item limit
- Meal standards
- Photo standards
- Restaurant payout
- Email templates
- SMS templates
- Launch date
- Feature flags
- Public announcements
- Maintenance state

## 19.11 System health

- Website
- API
- Database
- Stripe webhooks
- Email provider
- SMS provider
- Route service
- Background jobs
- Recent critical errors
- Deployment version
- Last successful test
- Backup status
- Environment
- Feature flags

---

# 20. AUTONOMOUS OPERATING MODEL

RocketPlate should run through controlled automation and exception queues. “Autonomous” does not mean uncontrolled.

## 20.1 Core principle

Automate routine, reversible, rules-based work. Require human approval for high-risk, financial, legal, food-safety, or permanent decisions.

## 20.2 Recommended agents

### 1. Restaurant Intake Agent

- Validates application completeness
- Enriches allowed public information
- Scores service-area fit
- Flags missing documents
- Creates CRM tasks

### 2. Partner Review Agent

- Scores reviews, popularity, capacity, cuisine fit, and readiness
- Recommends approve, conditional approve, waitlist, or decline
- Produces evidence and reasoning

### 3. Menu and Photo Approval Agent

- Checks portion structure
- Checks economics
- Checks allergens
- Checks photo quality
- Produces precise revision requests

### 4. Production Coordinator Agent

- Freezes counts
- Sends restaurant counts
- Tracks acknowledgments
- Detects capacity conflicts
- Generates production and label jobs

### 5. Dispatch Agent

- Groups stops
- Requests route optimization
- Assigns routes under defined rules
- Watches pickups and scan events
- Flags late-risk routes
- Escalates exceptions

### 6. Billing Guardian Agent

- Verifies notification sequence
- Verifies charge gate
- Detects duplicate subscription risk
- Detects failed payment
- Never creates a charge outside approved policy

### 7. Customer Support Agent

- Answers FAQs
- Reads account state
- Creates tickets
- Issues only policy-approved credits
- Escalates food-safety, allergen, refund, or billing disputes

### 8. Restaurant Success Agent

- Reminds partners of tasks
- Summarizes performance
- Suggests corrections
- Escalates repeated misses

### 9. Growth and Expansion Agent

- Ranks ZIP codes
- Identifies cuisine gaps
- Tracks referrals
- Suggests outreach
- Never fabricates demand

### 10. Founder Briefing Agent

Sends a daily report containing:

- New waitlist signups
- New Founding Crew reservations
- Restaurant pipeline
- Menu approvals
- Operational risks
- Billing status
- System errors
- Unit economics
- Required founder decisions

## 20.3 Event-driven workflows

Use database events, scheduled jobs, queues, and idempotent actions.

Examples:

- Waitlist submitted → confirmation → CRM → ZIP demand update
- Founding card saved → confirmation → admin alert → reserved state
- Launch date set → schedule 72/48/24 notices
- Menu submitted → AI review → revision or human queue
- Count cutoff reached → production sheet → restaurant acknowledgment
- Restaurant ready → labels → pickup alert
- Driver pickup scan → customer route notification
- Failed delivery → support ticket → customer notification
- Low meal rating → quality-review queue

## 20.4 Human approval boundaries

Require a human or audited policy gate for:

- Charging a customer
- Activating a service area
- Final restaurant activation
- Permanent restaurant rejection
- Food-safety suspension
- High-value refund
- Changing pricing
- Changing promotion terms
- Changing payout terms
- Publishing a real restaurant name
- Production deployment
- DNS or domain changes

---

# 21. DATA MODEL

Use the existing schema where possible. Extend through migrations rather than creating competing tables.

Core entities:

- User
- Role
- Permission
- CustomerProfile
- Address
- ServiceArea
- ZipDemand
- WaitlistEntry
- FoundingReservation
- FoundingBenefit
- StripeCustomerReference
- PaymentMethodReference
- SubscriptionPlan
- Subscription
- Promotion
- PromotionRedemption
- Referral
- Restaurant
- RestaurantContact
- RestaurantApplication
- RestaurantWaitlistEntry
- RestaurantDocument
- RestaurantScore
- PartnerOnboardingTask
- Menu
- MenuItem
- MenuItemVersion
- MenuApproval
- PhotoAsset
- PhotoReview
- MealStandard
- Allergen
- DietaryTag
- ProductionDay
- ProductionCount
- Order
- OrderItem
- Bag
- Label
- ScanEvent
- DeliveryWindow
- Route
- RouteStop
- Driver
- DeliveryEvent
- Exception
- Payout
- Notification
- EmailEvent
- SmsEvent
- SupportTicket
- Review
- Refund
- Configuration
- FeatureFlag
- AnalyticsEvent
- AuditLog
- AgentRun
- AgentDecision

Every important object needs:

- Status
- Created and updated timestamps
- Owner or actor
- Version where appropriate
- Audit history
- Source
- Soft-delete or archival strategy where appropriate

---

# 22. EMAIL AND SMS SYSTEM

## Customer

- Waitlist confirmation
- Founding Crew confirmation
- Payment method saved
- Account verification
- Welcome
- Service-area launch date
- 72-hour pre-charge notice
- 48-hour pre-charge notice
- 24-hour pre-charge notice
- Subscription activation
- Payment receipt
- Payment failed
- Plan changed
- Plan paused
- Plan canceled
- Meal-selection reminder
- Delivery reminder
- Route update
- Delivery confirmation
- Referral milestone
- Support confirmation

## Restaurant

- Application received
- Restaurant waitlist confirmation
- Information requested
- Conditional approval
- Approval
- Decline or defer
- Onboarding invitation
- Task reminder
- Menu submitted
- Menu approved
- Menu revision requested
- Production count
- Count adjustment
- Production reminder
- Pickup reminder
- Payout statement
- Partner-status change
- Support confirmation

## Admin

- High-intent Founding Crew reservation
- New restaurant application
- Service-area threshold reached
- Capacity warning
- Payment failure spike
- Missing notification
- Route risk
- Restaurant late
- Food-safety or allergen escalation
- Critical system error

Requirements:

- Branded
- Mobile-friendly
- Accessible
- Correct sender domain
- Clear next action
- Marketing and transactional consent separated
- Unsubscribe handling
- Duplicate-send prevention
- Delivery error logging
- Test-send capability
- Notification timeline visible in admin

---

# 23. ANALYTICS

Track meaningful events without sending payment secrets or unnecessary personal data.

## Public and conversion

- Homepage viewed
- Cinematic loaded
- Cinematic started
- Cinematic skipped
- Cinematic completed
- ZIP check started
- ZIP result
- Waitlist started
- Waitlist completed
- Founding Crew started
- Payment method saved
- Founding Crew completed
- Restaurant interest started
- Restaurant application completed
- Restaurant waitlist completed
- Referral shared

## Subscriber

- Login
- Dashboard activated
- Meal selected
- Meal changed
- Plan changed
- Pause
- Cancellation
- Delivery viewed
- Support request
- Meal rating
- Delivery rating

## Restaurant

- Application state changed
- Onboarding task completed
- Menu submitted
- Menu approved
- Menu revision requested
- Production count viewed
- Labels printed
- Ready for pickup
- Pickup completed
- Payout viewed

## Operations

- Route generated
- Bag scan
- Pickup scan
- Delivery completed
- Delivery exception
- Notification sent
- Charge gate passed
- Charge gate blocked
- Payment success
- Payment failure

---

# 24. IMMERSIVE 3D STORYLINE

## 24.1 Creative thesis

RocketPlate is not simply a delivery service. It is a recurring local dinner mission.

- The cinematic layer creates wonder.
- Real food creates appetite.
- Clear pricing and consent create trust.
- Local restaurant stories create community value.
- The conversion system turns attention into measurable demand.

## 24.2 Character system

### Rocky

Rocky is the RocketPlate rocket and the primary visual guide.

- Premium collectible quality
- Rounded, tactile form
- Exact approved silhouette and colors
- Friendly motion
- Natural banking
- Soft launch clouds
- No military or generic spacecraft redesign

### L.I.F.T.-3.3

**Launch Intelligence for Food & Taste — Version 3.3**

Public name: **Lift**

Lift is RocketPlate’s calm mission-control chef intelligence.

- Warm
- Capable
- Concise
- Optimistic
- Slightly witty
- Never threatening
- Never presented as replacing chefs

## 24.3 Intro sequence

### Scene 0 — Signal

- Deep navy space
- Small orange signal
- Live HTML: `ROCKETPLATE MISSION CONTROL`
- Live HTML: `LOCATING PILOT LAUNCH ZONE`

### Scene 1 — Earth

- Controlled orbital movement
- Florida begins to glow
- Live HTML: `SOUTH FLORIDA IDENTIFIED`
- Live HTML: `LOCAL DINNER NETWORK ONLINE`

### Scene 2 — South Florida

- Coastline
- Warm city clusters
- Mission beacons
- Live HTML: `PREPARING FIRST LAUNCH`

### Scene 3 — Miami-Dade

- Miami-Dade becomes dominant
- Kendall becomes the approved target
- Do not imply service in unsupported zones

### Scene 4 — Kendall Launch Zone

- Local kitchen beacons
- Route lines
- Neighborhood geometry
- Live HTML: `KENDALL LAUNCH ZONE CONFIRMED`

### Scene 5 — Rocky Arrives

- Rocky follows the route
- Banks around the map
- Lift appears in the cockpit
- Live HTML: `L.I.F.T.-3.3 ONLINE`
- Live HTML: `LOCAL KITCHENS DETECTED`

### Scene 6 — Cockpit Portal

- Camera enters Rocky’s window
- Route lines become interface dividers
- Beacons become real meal cards
- Stars become steam and warm particles
- Last cinematic frame matches the first live hero frame

### Scene 7 — Live Hero Loop

- Rocky floats gently
- Kendall beacon pulses
- One route activates
- Lift checks mission display
- Subtle 12–20 second loop
- Headline: **Dinner, cleared for launch.**
- CTA: **Join the Mission**
- CTA: **Reserve Founding Crew**
- Link: **See How RocketPlate Works**

## 24.4 Scroll story

1. The signal: dinner planning is broken
2. The network: local kitchens have unused afternoon capacity
3. The standard: RocketPlate approves complete meals, portions, photos, and capacity
4. The mission: subscribers choose a weekly plan
5. The preparation: restaurants cook in a focused batch
6. The launch: labels, routes, and bags are coordinated
7. The delivery: complete hot dinners arrive in one focused evening window
8. The community: subscribers gain convenience and restaurants gain predictable revenue
9. The invitation: Explorer, Founding Crew, or Restaurant Partner

## 24.5 Hybrid implementation

Use:

1. Higgsfield for controlled film-quality noninteractive shots
2. React Three Fiber or Three.js for live spatial interaction
3. GSAP only for deliberate timeline synchronization
4. HTML/CSS for all critical copy, forms, food cards, pricing, legal, and accessibility

Do not put critical copy inside generated video.

## 24.6 Performance tiers

### High-capability device

- Realtime globe
- Full Rocky model
- Controlled particles
- Limited post-processing

### Medium

- Reduced geometry
- Lower device-pixel ratio
- Fewer particles
- Simplified shadows

### Low

- Pre-rendered clip
- Static hero
- Standard HTML experience

### Reduced motion

- Static Earth-to-Kendall sequence
- Crossfades
- Immediate access to content
- No forced movement

### Data saver

- Poster first
- No large autoplay video
- Optional play button

Always provide:

- Skip intro
- No autoplay audio
- Keyboard access
- Visible focus
- Pause continuous motion
- Captions or transcript
- Meaningful HTML before 3D
- Mobile fallback
- No blank canvas

---

# 25. 3D CREATIVE APPROVAL PROCESS

Do not let Claude directly redesign and deploy the cinematic experience without checkpoints.

## Stage 1 — Narrative approval

Claude delivers:

- Story premise
- Scene list
- Emotional arc
- Copy
- CTA map
- Mobile fallback
- Conversion logic

No production code yet.

## Stage 2 — Visual and asset approval

Claude delivers:

- Asset inventory
- Canonical character references
- Storyboard frames
- Camera plan
- Lighting plan
- 3D model requirements
- Higgsfield shot list
- Continuity sheet
- Performance budget

## Stage 3 — Prototype approval

Claude builds:

- Separate branch
- Vercel preview
- Low-risk 3D prototype
- Fallback experience
- Analytics
- No production billing changes
- No DNS changes

## Stage 4 — Production approval

Required:

- Founder approval
- Mobile QA
- Accessibility QA
- Performance QA
- Conversion QA
- Form QA
- No broken account flows
- Rollback plan
- Production promotion

---

# 26. CLAUDE / FABLE PROMPT PACK

## PROMPT 1 — MASTER AUDIT AND IMPLEMENTATION

```text
You are Fable, acting as RocketPlate’s principal product architect, senior full-stack engineer, operations designer, conversion strategist, restaurant-platform architect, automation engineer, QA lead, security reviewer, and release manager.

Read ROCKETPLATE_MASTER_PLATFORM_IMMERSIVE_BUILD_BLUEPRINT.md completely before changing code.

Your first job is not to redesign. Audit the existing SaaSWrld/RocketPlate repository, current branches, deployments, Supabase schema, Stripe integration, Resend integration, authentication, routes, dashboards, forms, analytics, media, brand assets, and environment configuration.

Preserve strong working systems. Do not create a disconnected prototype or competing backend.

Create:
- ROCKETPLATE_SYSTEM_MAP.md
- ROCKETPLATE_AUDIT.md
- ROCKETPLATE_DECISION_LOG.md
- ROCKETPLATE_LAUNCH_CHECKLIST.md
- ROCKETPLATE_PHASE_2_BACKLOG.md

Classify every feature as:
- working and keep
- working but disconnected
- incomplete
- broken
- duplicate
- unsafe
- launch-critical
- Phase 2

Then implement in this order:
1. Build stability
2. Data model and authentication
3. Service-area ZIP check
4. Explorer waitlist
5. Founding Crew SetupIntent flow
6. 72/48/24-hour billing guard
7. Subscriber dashboard
8. Restaurant application and waitlist
9. Restaurant approval and onboarding
10. Menu and photo approval
11. Restaurant dashboard
12. Label, packout, and production system
13. Driver and dispatch views
14. Master admin dashboard
15. Promotions and economics simulator
16. Email and SMS workflows
17. Analytics
18. Security and permissions
19. End-to-end testing
20. Immersive experience on a separate preview branch
21. Launch report

Rules:
- No fake data
- No accidental charges
- No raw card storage
- No restaurant names without approval
- No unapproved meals shown publicly
- No production deployment without tests
- No DNS change without founder approval
- No cosmetic redesign that breaks working functionality
- Use real empty states instead of fake active modules
- Keep every important business rule configurable
- Use migrations
- Enforce server-side authorization
- Log sensitive actions
- Keep a rollback path

Deliver a working preview, test results, known limitations, blockers, exact founder actions, and separate readiness ratings for:
A. Public discovery and lead capture
B. Controlled pilot operations
C. Paid subscription activation
D. Immersive 3D experience
```

## PROMPT 2 — STORY AND EXPERIENCE DESIGN

```text
Act as RocketPlate’s executive creative director, cinematic story director, 3D experience director, conversion strategist, product designer, accessibility lead, and performance lead.

Read the full RocketPlate master blueprint and audit the approved brand assets before proposing anything.

Create a narrative treatment for a premium, optimistic, family-friendly, cinematic RocketPlate website that begins with a mission signal, travels from Earth to South Florida to Miami-Dade to Kendall, introduces Rocky and L.I.F.T.-3.3, passes through Rocky’s cockpit, and transforms into the live website.

The story must explain the real business:
- local independent restaurants
- 2–4 PM batch production
- standardized complete meals
- weekly subscriptions
- focused evening delivery
- free Explorer waitlist
- Founding Crew card-on-file with no immediate charge
- restaurant partnership opportunity

Deliver:
1. Creative thesis
2. Scene-by-scene story
3. Camera and transition plan
4. Live HTML copy
5. CTA map
6. Food-photography integration
7. Restaurant story integration
8. Desktop, mobile, reduced-motion, and data-saver versions
9. Conversion objections answered by each section
10. Asset list
11. Risks and rejected ideas
12. Approval checklist

Do not build code until the narrative is approved.
Do not use cyberpunk, military, dystopian, generic SaaS, or generic food-delivery design.
Do not generate text inside video.
Do not imply unsupported service areas or restaurant partnerships.
```

## PROMPT 3 — HIGGSFIELD SHOT PRODUCTION

```text
Create a controlled RocketPlate cinematic shot plan for Higgsfield. Do not request one oversized generation.

Use approved reference elements:
@Rocky
@Lift33
@RocketPlateLogo
@SouthFlorida
@MiamiDade
@KendallLaunchZone
@MissionControl
@RocketPlateClouds

Create separate prompts for:
A. Earth to Florida
B. South Florida to Miami-Dade
C. Kendall launch-zone map
D. Rocky arrival
E. Lift cockpit reveal
F. Cockpit portal into the live hero

For every shot define:
- reference assets
- duration
- start frame
- end frame
- camera movement
- focal length
- lighting
- speed curve
- continuity requirements
- rejection criteria

Reject:
- character drift
- malformed logo
- incorrect fin count
- changed robot face
- extra characters
- fake restaurant brands
- generated text
- broken geography
- unstable camera direction
- wrong colors
- military styling
- cyberpunk styling

The final frame of the cinematic must match the initial realtime hero camera, lighting, Rocky position, scale, and Kendall beacon.
```

## PROMPT 4 — REALTIME 3D IMPLEMENTATION

```text
Act as a senior realtime-web architect.

Audit the existing frontend before choosing tools. Do not force a framework migration.

If the project is React/Next.js, prefer React Three Fiber. Otherwise use the existing compatible Three.js architecture.

Build the approved RocketPlate experience using:
- realtime 3D only for spatial scenes
- GSAP only for deliberate timeline synchronization
- HTML/CSS for copy, forms, food cards, pricing, navigation, support, and legal content
- Higgsfield video only for noninteractive film-quality segments

Requirements:
- WebGPU where safe
- WebGL fallback
- video fallback
- poster fallback
- reduced-motion fallback
- no blank canvas
- meaningful HTML loads first
- lazy loading
- compressed GLB/GLTF
- compressed textures
- paused offscreen rendering
- clamped device pixel ratio
- no unnecessary React state in animation loops
- GPU cleanup
- mobile performance testing
- skip intro
- no autoplay sound
- pause control
- analytics events
- accessibility labels
- no scroll hijacking
- no pinning every section

Build in a separate branch and Vercel preview. Do not change production billing, DNS, or customer data.
```

## PROMPT 5 — RESTAURANT AGENT SYSTEM

```text
Build RocketPlate’s controlled restaurant onboarding and menu-approval agent system.

Create:
1. Restaurant Intake Agent
2. Partner Review Agent
3. Menu Standards Agent
4. Food Photo QA Agent
5. Restaurant Success Agent

Each agent must:
- use structured inputs and outputs
- save evidence and confidence
- provide specific revision instructions
- create an audit record
- avoid irreversible action without permission
- never silently activate a restaurant
- never publish an unapproved meal
- never rely only on review score
- provide a fair path for new restaurants with limited review history

Implement the statuses, scoring criteria, photo rules, portion standards, menu fields, approval queue, admin override, and notifications from the master blueprint.

Use deterministic policy checks before LLM judgment where possible.
```

## PROMPT 6 — DELIVERY AND LABELING SYSTEM

```text
Build the pilot RocketPlate delivery control layer using the existing stack.

Required:
- production counts
- restaurant acknowledgments
- 2x1 meal labels
- 4x6 bag labels
- QR codes
- meal-to-bag scan
- bag-to-route scan
- driver pickup scan
- delivery confirmation
- route manifests
- restaurant staging plan
- driver PWA
- exception handling
- dispatch dashboard
- end-of-day reconciliation

Use Supabase as the source of truth. Use idempotent events. Preserve privacy on labels. Keep routes and windows configurable.

Do not build unnecessary enterprise complexity before the pilot. Deliver a reliable thin control layer with clear Phase 2 extension points.
```

## PROMPT 7 — LAUNCH QA AND RELEASE GATES

```text
Run full launch simulation using realistic seeded test data, never real customer card data.

Test these personas:
1. Unsupported-area visitor joins Explorer
2. Eligible visitor joins Explorer
3. Eligible visitor reserves Founding Crew
4. Founding member updates card
5. Founding member cancels before launch
6. Launch date triggers 72/48/24 notices
7. Missing notice blocks activation
8. Duplicate webhook does not double-charge
9. Restaurant outside area joins waitlist
10. Eligible restaurant applies
11. Restaurant receives information request
12. Restaurant is approved
13. Restaurant completes onboarding
14. Restaurant submits a meal with a bad photo
15. AI requests revision
16. Corrected meal is approved
17. Production counts are generated
18. Labels print
19. Bags scan into a route
20. Driver completes delivery
21. Delivery exception creates support workflow
22. Admin reviews economics and system health
23. Reduced-motion user accesses the full site
24. Mid-tier mobile device loads a usable experience

Report separate Green, Yellow, or Red status for:
- Gate A: public discovery and lead capture
- Gate B: controlled pilot operations
- Gate C: paid subscription activation
- Gate D: immersive experience

Never label a gate Green unless all critical acceptance tests pass.
```

---

# 27. TONIGHT’S IMPLEMENTATION ORDER

1. Audit current repository and live routes
2. Stabilize production build
3. Confirm Supabase tables and permissions
4. Complete ZIP availability result
5. Complete Explorer form and confirmation
6. Complete Founding Crew SetupIntent without charge
7. Add explicit future-charge disclosures
8. Add Founding Crew prelaunch dashboard
9. Complete restaurant information, application, and waitlist
10. Complete admin visibility for all submissions
11. Test Resend confirmations
12. Add legal and support surfaces
13. Add analytics
14. Deploy a functional preview
15. Add a lightweight cinematic entrance or existing approved film asset
16. Keep the full realtime 3D system on a preview branch until performance and conversion pass
17. Run Gate A simulation
18. Promote only verified Gate A functionality
19. Leave Gate C billing disabled
20. Produce founder launch report

---

# 28. DEFINITION OF DONE

## Gate A is ready when

- Public pages load
- Mobile works
- ZIP check works
- Explorer saves real data
- Explorer email works
- Founding card saves with no charge
- Founding email works
- Restaurant application works
- Restaurant waitlist works
- Admin can see submissions
- Legal and support links work
- Analytics works
- No critical dead ends
- No fake data
- No exposed secrets
- Accessibility basics pass

## Gate B is ready when

- Restaurant login works
- Onboarding works
- Menu submission works
- AI review works
- Human approval works
- Meal standards are enforced
- Production counts work
- Labels work
- Scans work
- Dispatch works
- Driver flow works
- Exceptions work
- Payout records work
- Full pilot simulation passes

## Gate C is ready when

- 72/48/24 notices work
- Every notice is logged
- Cancellation works
- Card update works
- Charge gate works
- Duplicate charges are blocked
- Stripe webhooks are verified
- Failed payment workflow works
- Billing audit works
- Authorized production smoke test passes

## Gate D is ready when

- Story approved
- Assets approved
- Mobile performance passes
- Reduced motion passes
- Data saver passes
- Skip intro works
- Conversion forms remain easy to use
- No critical copy is trapped in video
- No unapproved restaurant names appear
- Rollback exists

---

# 29. FOUNDER DECISION QUESTIONNAIRE

These questions should be answered in the decision log, but they must not block Gate A unless specifically marked critical.

## Critical before paid activation

1. Which ZIP codes are in the first paid pilot?
2. What exact date will the first area launch?
3. Which days of the week will RocketPlate deliver during the pilot?
4. Is the customer delivery promise exactly 5:00–7:00 PM?
5. What is the maximum subscriber capacity for week one?
6. What is the maximum Founding Crew count: 100 or another number?
7. Are the first-week-free and 33%-off-month-two benefits still active at the new $89.99 and $129.99 prices?
8. Does the 12-month lock require continuous active membership?
9. What happens to the lock after a pause or failed payment?
10. What cancellation cutoff applies to the first charge?
11. Which communication channels are mandatory: email only or email plus consented SMS?
12. What refund and credit authority can the support agent use without approval?
13. What exact restaurant payout ceiling applies to the pilot?
14. Is the $1.00-per-meal kitchen staff incentive paid separately or included in the restaurant payout?
15. Who provides containers, bags, seals, and labels?
16. Which thermal printer and label sizes will be standardized?
17. Who performs the final restaurant activation approval?
18. What food-safety and insurance documents are mandatory?
19. What payment/payout provider will restaurants use?
20. Which signed restaurant agreements are required before public naming?

## Operational decisions

21. Will subscribers select individual meals every week, receive a curated rotation, or use a hybrid?
22. How many restaurants can one subscriber choose from in one delivery day?
23. Can a customer receive meals from more than one restaurant in one bag?
24. What is the same-day add-on price and capacity rule?
25. What plan-change cutoff applies?
26. What pause rules apply?
27. What delivery attempt and redelivery policy applies?
28. What proof-of-delivery method is preferred?
29. What customer data may drivers see?
30. What is the restaurant shortage and substitution policy?
31. What quality score pauses a meal or restaurant?
32. What review source integrations are legally approved?
33. Who handles allergen escalations?
34. Will restaurants print labels, or will RocketPlate preprint and deliver them?
35. How many routes and drivers are planned for the first week?

## Family plan decisions

36. Is the family product three family dinners, five dinners, or another structure?
37. How many people must each family dinner feed?
38. Will family meals be one entrée plus two sides?
39. Can family meals be customized?
40. What packaging cost and restaurant payout are sustainable?
41. Should the site collect interest only until pilot data is available?

## Creative decisions

42. Is the opening experience primarily Higgsfield video, realtime 3D, or a hybrid?
43. Should returning visitors skip directly to the live hero?
44. Is the full intro played once per device, once per session, or by user choice?
45. Which approved Rocky and Lift files are canonical?
46. Is the robot’s public name Lift, Mochi, or a different final system?
47. What exact logo/domain lockup appears on Rocky?
48. Which real meal photos are approved for launch?
49. Which restaurants may be named publicly?
50. Should the 3D narrative emphasize convenience, local restaurants, affordability, or the full mission equally?

---

# 30. FINAL OPERATING PRINCIPLES

- Audit first
- Preserve working systems
- One source of truth
- One connected platform
- Real data only
- No accidental charges
- No hidden billing
- No unapproved restaurant names
- No unapproved meals
- No fake dashboards
- No silent failures
- No production deployment without simulation
- No 3D effect that harms usability
- No AI decision without evidence and audit
- No autonomous financial action outside policy
- Build the smallest reliable pilot system
- Make business rules configurable
- Keep the customer experience simple
- Keep restaurant onboarding fast
- Keep delivery labeling obvious
- Make exceptions visible
- Protect customer and restaurant trust
- Measure acquisition, conversion, retention, quality, density, and margin
- Launch Gate A fast
- Activate paid delivery only when Gates B and C are truly ready

---

# END OF MASTER BLUEPRINT
