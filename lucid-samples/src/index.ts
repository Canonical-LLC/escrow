import { PlutusData, Construct } from 'lucid-cardano';

const buyDatum: PlutusData = new Construct(1, [
  new Construct(0, []),
  new Construct(0, [
    new Construct(0, [
      '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
      {
        d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2: {
          '123456': 1,
        },
      },
      [
        new Construct(0, [
          '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
          {
            '': {
              '': 49000000,
            },
          },
        ]),
        new Construct(0, [
          '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
          {
            '': {
              '': 1000000,
            },
          },
        ]),
      ],
      1648849688000,
      '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
    ]),
    new Construct(0, [
      '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
      [
        new Construct(0, [
          '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
          {
            d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2: {
              '123456': 1,
            },
          },
        ]),
      ],
    ]),
  ]),
]);

const sellDatum: PlutusData = new Construct(0, [
  new Construct(0, [
    '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
    {
      d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2: { '123456': 1 },
    },
    [
      new Construct(0, [
        '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
        {
          '': {
            '': 49000000,
          },
        },
      ]),
      new Construct(0, [
        '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
        {
          '': {
            '': 1000000,
          },
        },
      ]),
    ],
    1648849688000,
    '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
  ]),
]);

const cancelRedeemer: PlutusData = new Construct(2, [
  new Construct(0, [
    '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
    new Construct(0, []),
  ]),
]);

const buyerApprovesRedeemer: PlutusData = new Construct(2, [
  new Construct(0, [
    '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
    new Construct(1, []),
  ]),
]);

const mediatorApprovesRedeemer: PlutusData = new Construct(2, [
  new Construct(0, [
    '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
    new Construct(1, []),
  ]),
]);

console.log(buyDatum);
console.log(sellDatum);
console.log(cancelRedeemer);
console.log(buyerApprovesRedeemer);
console.log(mediatorApprovesRedeemer);
