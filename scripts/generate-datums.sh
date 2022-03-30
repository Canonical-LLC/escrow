#!/usr/bin/env bash

set -eux
thisDir=$(dirname "$0")
tempDir=$thisDir/../temp

nowSeconds=$(date +%s)
now=$(($nowSeconds*1000))
timestamp=$(($nowSeconds*1000+$1))
betterOfferTimestamp=$(($timestamp+5000000000))
prefix=${2:-0}

mkdir -p $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix
mkdir -p $tempDir/$BLOCKCHAIN_PREFIX/redeemers/$prefix

sellerPkh=$(cat $tempDir/$BLOCKCHAIN_PREFIX/pkhs/seller-pkh.txt)
marketplacePkh=$(cat $tempDir/$BLOCKCHAIN_PREFIX/pkhs/marketplace-pkh.txt)
royaltyPkh=$(cat $tempDir/$BLOCKCHAIN_PREFIX/pkhs/royalities-pkh.txt)
buyerPkh=$(cat $tempDir/$BLOCKCHAIN_PREFIX/pkhs/buyer-pkh.txt)

read -r -d '' OFFER << EOF || :
    {
      "constructor": 0,
      "fields": [
        {
          "bytes": "$sellerPkh"
        },
        {
          "map": [
            {
              "k": {
                "bytes": "d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2"
              },
              "v": {
                "map": [
                  {
                    "k": {
                      "bytes": "123456"
                    },
                    "v": {
                      "int": 1
                    }
                  }
                ]
              }
            }
          ]
        },
        {
          "list": [
            {
              "constructor": 0,
              "fields": [
                {
                  "bytes": "$sellerPkh"
                },
                {
                  "map": [
                    {
                      "k": {
                          "bytes": ""
                        },
                      "v": {
                        "map":[
                          { "k":
                            {
                              "bytes": ""
                            },
                            "v":
                            {
                              "int": 8000000
                            }
                          }
                        ]
                      }
                    }
                  ]
                }
              ]
            },
            {
              "constructor": 0,
              "fields": [
                {
                  "bytes": "$marketplacePkh"
                },
                {
                  "map": [
                    {
                      "k":
                        {
                          "bytes": ""
                        },
                      "v": {
                        "map": [
                          { "k":
                            {
                              "bytes": ""
                            }
                          ,
                            "v":
                            {
                              "int": 1000000
                            }
                          }
                        ]
                      }
                    }
                  ]
                }
              ]
            },
            {
              "constructor": 0,
              "fields": [
                {
                  "bytes": "$royaltyPkh"
                },
                {
                  "map": [
                    {
                      "k": {
                          "bytes": ""
                        },
                      "v": {
                        "map": [
                          {
                            "k": {
                          "bytes": ""
                        },
                            "v":
                            {
                              "int": 1000000
                            }
                          }
                        ]
                      }
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "int": $timestamp
        },
        {
          "bytes": "$marketplacePkh"
        }
      ]
    }
EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/offer.json
{ "constructor": 0,
  "fields": [
    $OFFER
  ]
}

EOF

read -r -d '' BUYPAYOUTS << EOF || :
{
  "constructor": 0,
  "fields": [
    {
      "bytes": "$buyerPkh"
    },
    {
      "list": [
        {
          "constructor": 0,
          "fields": [
            {
              "bytes": "$buyerPkh"
            },
            {
              "map": [
                {
                  "k": {
                    "bytes": "d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2"
                  },
                  "v": {
                    "map": [
                      {
                        "k": {
                          "bytes": "123456"
                        },
                        "v": {
                          "int": 1
                        }
                      }
                    ]
                  }
                }
              ]
            }
          ]
        }
      ]
    }

  ]
}
EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/redeemers/$prefix/buy.json
{
  "constructor": 1,
  "fields": [
    $BUYPAYOUTS
  ]
}

EOF

read -r -d '' NOAPPROVAL << EOF || :
    {
      "constructor": 0,
      "fields": [
      ]
    }
EOF

read -r -d '' ESCROW << EOF || :
    {
      "constructor": 0,
      "fields": [
        $OFFER,
        $BUYPAYOUTS
      ]
    }
EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/buy.json
{
  "constructor": 1,
  "fields": [
    $NOAPPROVAL,
    $ESCROW
  ]
}

EOF

read -r -d '' TRUE << EOF || :
{ "constructor": 1, "fields": [] }
EOF

read -r -d '' FALSE << EOF || :
{ "constructor": 0, "fields": [] }
EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/redeemers/$prefix/seller-approves.json
{
  "constructor": 2,
  "fields": [
    {
      "constructor": 0,
      "fields": [
        {
          "bytes": "$sellerPkh"
        },
        $TRUE
      ]
    }
  ]
}
EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/redeemers/$prefix/seller-rejects.json
{
  "constructor": 2,
  "fields": [
    {
      "constructor": 0,
      "fields": [
        {
          "bytes": "$sellerPkh"
        },
        $FALSE
      ]
    }
  ]
}
EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/redeemers/$prefix/mediator-rejects.json
{
  "constructor": 2,
  "fields": [
    {
      "constructor": 0,
      "fields": [
        {
          "bytes": "$marketplacePkh"
        },
        $FALSE
      ]
    }
  ]
}
EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/redeemers/$prefix/mediator-approves.json
{
  "constructor": 2,
  "fields": [
    {
      "constructor": 0,
      "fields": [
        {
          "bytes": "$marketplacePkh"
        },
        $TRUE
      ]
    }
  ]
}
EOF

read -r -d '' APPROVEDBY_SELLER << EOF || :
{
  "constructor": 1,
  "fields": [
    {
      "bytes": "$sellerPkh"
    }
  ]
}
EOF

read -r -d '' APPROVEDBY_BUYER << EOF || :
{
  "constructor": 1,
  "fields": [
    {
      "bytes": "$buyerPkh"
    }
  ]
}

EOF

read -r -d '' REJECTEDBY_SELLER << EOF || :
{
  "constructor": 2,
  "fields": [
    {
      "bytes": "$sellerPkh"
    }
  ]
}

EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/seller-approved.json
{
  "constructor": 1,
  "fields": [
    $APPROVEDBY_SELLER,
    $ESCROW
  ]
}
EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/buyer-approved.json
{
  "constructor": 1,
  "fields": [
    $APPROVEDBY_BUYER,
    $ESCROW
  ]
}
EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/seller-rejected.json
{
  "constructor": 1,
  "fields": [
    $REJECTEDBY_SELLER,
    $ESCROW
  ]
}
EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/redeemers/$prefix/buyer-approves.json
{
  "constructor": 2,
  "fields": [
    {
      "constructor": 0,
      "fields": [
        {
          "bytes": "$buyerPkh"
        },
        $TRUE
      ]
    }
  ]
}
EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/redeemers/$prefix/buyer-rejects.json
{
  "constructor": 2,
  "fields": [
    {
      "constructor": 0,
      "fields": [
        {
          "bytes": "$buyerPkh"
        },
        $FALSE
      ]
    }
  ]
}
EOF


read -r -d '' APPROVEDBYSELLER_REJECTEDBYBUYER << EOF || :
{
  "constructor": 3,
  "fields": [
    {
      "bytes": "$sellerPkh"
    },
    {
      "bytes": "$buyerPkh"
    }
  ]
}
EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/buyer-rejected.json
{
  "constructor": 1,
  "fields": [
    $APPROVEDBYSELLER_REJECTEDBYBUYER,
    $ESCROW
  ]
}
EOF

read -r -d '' OFFER_NOPAY << EOF || :
    {
      "constructor": 0,
      "fields": [
        {
          "bytes": "$sellerPkh"
        },
        {
          "map": [
            {
              "k": {
                "bytes": "d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2"
              },
              "v": {
                "map": [
                  {
                    "k": {
                      "bytes": "123456"
                    },
                    "v": {
                      "int": 1
                    }
                  }
                ]
              }
            }
          ]
        },
        {
          "list": [
          ]
        },
        {
          "int": $timestamp
        },
        {
          "bytes": "$marketplacePkh"
        }
      ]
    }
EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/offer-nopayment.json
{ "constructor": 0,
  "fields": [
    $OFFER_NOPAY
  ]
}

EOF


read -r -d '' ESCROW_NOPAY << EOF || :
    {
      "constructor": 0,
      "fields": [
        $OFFER_NOPAY,
        $BUYPAYOUTS
      ]
    }
EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/buy-nopayment.json
{
  "constructor": 1,
  "fields": [
    $NOAPPROVAL,
    $ESCROW_NOPAY
  ]
}

EOF
cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/seller-approved-nopayment.json
{
  "constructor": 1,
  "fields": [
    $APPROVEDBY_SELLER,
    $ESCROW_NOPAY
  ]
}
EOF
