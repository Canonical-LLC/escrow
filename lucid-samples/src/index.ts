import { Construct, Data } from 'lucid-cardano';

export const buyDatum: Data = Data.from(
  new Construct(1, [
    new Construct(0, []),
    new Construct(0, [
      new Construct(0, [
        '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
        {
          d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2: {
            '123456': BigInt(1),
          },
        },
        [
          new Construct(0, [
            '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
            {
              '': {
                '': BigInt(49000000),
              },
            },
          ]),
          new Construct(0, [
            '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
            {
              '': {
                '': BigInt(1000000),
              },
            },
          ]),
        ],
        BigInt(1648849688000),
        '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
      ]),
      new Construct(0, [
        '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
        [
          new Construct(0, [
            '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
            {
              d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2: {
                '123456': BigInt(1),
              },
            },
          ]),
        ],
      ]),
    ]),
  ]),
);

export const sellDatum: Data = Data.from(
  new Construct(0, [
    new Construct(0, [
      '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
      {
        d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2: {
          '123456': BigInt(1),
        },
      },
      [
        new Construct(0, [
          '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
          {
            '': {
              '': BigInt(49000000),
            },
          },
        ]),
        new Construct(0, [
          '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
          {
            '': {
              '': BigInt(1000000),
            },
          },
        ]),
      ],
      BigInt(1648849688000),
      '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
    ]),
  ]),
);

export const cancelRedeemer: Data = Data.from(
  new Construct(2, [
    new Construct(0, [
      '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
      new Construct(0, []),
    ]),
  ]),
);

export const buyerApprovesRedeemer: Data = Data.from(
  new Construct(2, [
    new Construct(0, [
      '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
      new Construct(1, []),
    ]),
  ]),
);

export const mediatorApprovesRedeemer: Data = Data.from(
  new Construct(2, [
    new Construct(0, [
      '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
      new Construct(1, []),
    ]),
  ]),
);
