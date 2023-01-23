# Overview

Interact with [Yelp](https://docs.developer.yelp.com/reference) from Powershell

## Status

[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/Yelp)](https://www.powershellgallery.com/packages/Yelp)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/Yelp?color=green)](https://www.powershellgallery.com/packages/Yelp)
[![GitHub license](https://img.shields.io/github/license/chris-peterson/pwsh-yelp.svg)](LICENSE)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/chris-peterson/pwsh-yelp/deploy.yml?branch=main&label=ci)](https://github.com/chris-peterson/pwsh-yelp/actions/workflows/deploy.yml)

## Getting Started

`Install-Module Yelp`

### API Key

If you haven't already, sign up for an API key and follow [Yelp's Fusion Intro](https://docs.developer.yelp.com/docs/fusion-intro).

Export your Yelp API keys as environment variables, e.g.

```powershell
$env:YELP_API_SECRET = '...'
```

## Examples

### Find a Library

```powershell
Search-YelpBusiness libraries
```
```text
ID                     Name                                                             Address
--                     ----                                                             -------
DtiSFz1gp1tcI2RtIeUVbg Seattle Public Library - Central Library                         {1000 Fourth Ave, Seattle, WA 98104}
k-MtN0JAOZBSmFPmcfJoSg Seattle Public Library - Beacon Hill Branch                      {2821 Beacon Ave S, Seattle, WA 98144}
KJ6Z8mrw_ZwhGJ0X2-XZBg Seattle Public Library - Capitol Hill Branch                     {425 Harvard Ave E, Seattle, WA 98102}
pMQjRAZQGO-yMC--qPmGZQ Seattle Public Library - West Seattle Branch                     {2306 42nd Ave SW, Seattle, WA 98116}
te7Q5C8kZL2FtLY4pqkFUg West Seattle Tool Library                                        {4408 Delridge Way SW, Youngstown Cultural Arts Ctr, Seattle, WA 98106}
dPcM-e73PE9yQdygQPq1CQ Seattle Public Library - Southwest Branch                        {9010 35th Ave SW, Seattle, WA 98126}
hY8o32AkloCBU3to24l0cA White Center Library                                             {1409 SW 107th St, Seattle, WA 98146}
hpGa02yaJft5PQ_mviOKmA Seattle Public Library - Douglass-Truth Branch                   {2300 E Yesler Way, Seattle, WA 98122}
lII51wV067VHPrtCk4IIyg Seattle Public Library - Delridge Branch                         {5423 Delridge Way SW, Seattle, WA 98106}
LrX6QTjiTF__FuUfYOTVxA Seattle Public Library - High Point Branch                       {3411 SW Raymond St, Seattle, WA 98126}
4Q9Sx0R6fuj1-vjcnRetPA Seattle Public Library - Queen Anne Branch                       {400 W Garfield St, Seattle, WA 98119}
Dh_Yh9Mw4quFVEztV3qg8w Seattle Public Library - Montlake Branch                         {2401 24th Ave E, Seattle, WA 98112}
3PwKcUNX3QC8UFpbAsgNpw Seattle Public Library - Magnolia Branch                         {2801 34th Ave W, Seattle, WA 98199}
MZk_Px82geapRAvcCIesog Greenbridge Library                                              {9720 8th Ave SW, Seattle, WA 98106}
yD6HQpqsGfJwwGw_R1vi6w Seattle Public Library - International District Chinatown Branch {713 Eighth Ave S, International District Village Square II, Seattle, WA 98104}
eS8kUYGo2AGT54wW4tEHtA Washington Talking Book & Braille Library and Mobile Services    {2021 9th Ave, Seattle, WA 98121}
UOelSzXn5arANPgwSeELug Seattle Public Library - South Park Branch                       {8604 Eighth Ave S, Seattle, WA 98108}
pk-FMke9IdKVMAseQ_fHBw Lemieux Library & McGoldrick Learning Commons                    {901 12th Ave, Seattle, WA 98122}
PtGGiLFgtp0EdMOlW3OclA Seattle Central College Library                                  {1701 Broadway, BE 2101, Seattle Central College, Seattle, WA 98122}
```

### Is It Open?

```powershell
Get-YelpBusiness pMQjRAZQGO-yMC--qPmGZQ -select OpenTime
```
```text
Day       Opens Closes
---       ----- ------
Monday    10 AM 6 PM
Tuesday   10 AM 6 PM
Wednesday 12 AM 8 PM
Thursday  12 AM 8 PM
Friday    10 AM 6 PM
Saturday  10 AM 6 PM
Sunday    12 AM 5 PM
```
