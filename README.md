# UberCasts

The goal of this project was to estimate the long term effects on Uber's marketing campaign in the Bronx region. 

As an avid user of Uber, and an enthusiast of the sharing economy, I was keen on delving deeper into these numbers to understand wether this marketing intervention would be profitable for Uber in the long run.

Uber's blog post on the motivation behind the marketing campaign Select an Image

The promotion was applied for 2 rides (or up to $20) to or from the Bronx on the weekend of May 15th 2015. There were 3 questions I wanted to answer in this analysis.

Questions

1. Can we find what the volume of rides, post the May 15th weekend, would've been if the marketing intervention did not take place?

2. Can we calculate the effects of the promotion and juxtapose between the counterfactual?

3. Using the increment in rides calculated, does the promotion pay for itself?

Strategy

The next step was to create a strategy around making this analysis:

1. Facebook manages an open source project called Prophet. This has been specifically built to forecast data with inherent seasonal effects. We would be leveraging this package, and isolating the ride data from May 15th thereafter, to create a forecast of what the case would've been if the promotion did not occur.

2. By removing ridership data across the marketing intervention period, we can forecast what the volume of rides would have been.

3. Using the forecast, we can evaluate the effects of the promotion by calculating the cumulative increase in rides from the Monday after the promotion (May 18th) trough the end of June.

Assumptions

1. For the sake of simplicity, we will assume the promotion was only applied to rides originating from the Bronx 9 though it also applied to rides ending in the Bronx as well)

2. An average Uber fare in New York is $14

3. Average Uber fare commission is 25% (Thus payout to riders is $75; link)

4. This promotion only lasted for the 3 days between Friday May 15th 2015 and Sunday May 17th 2015
