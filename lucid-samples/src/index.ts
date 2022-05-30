import { Construct, Data, PlutusData } from 'lucid-cardano';

export const buyDatum: Data = Data.to(
  new Construct(1, [
    new Construct(0, []),
    new Construct(0, [
      new Construct(0, [
        '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
        new Map<string, PlutusData>([
          [
            'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
            new Map<string, PlutusData>([['123456', BigInt(1)]]),
          ],
        ]),
        [
          new Construct(0, [
            '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
            new Map<string, PlutusData>([
              ['', new Map<string, PlutusData>([['', BigInt(49000000)]])],
            ]),
          ]),
          new Construct(0, [
            '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
            new Map<string, PlutusData>([
              ['', new Map<string, PlutusData>([['', BigInt(1000000)]])],
            ]),
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
            new Map<string, PlutusData>([
              [
                'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
                new Map<string, PlutusData>([['123456', BigInt(1)]]),
              ],
            ]),
          ]),
        ],
      ]),
    ]),
  ]),
);

export const buyApprovedDatum: Data = Data.to(
  new Construct(1, [
    new Construct(1, [
      '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
    ]),
    new Construct(0, [
      new Construct(0, [
        '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
        new Map<string, PlutusData>([
          [
            'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
            new Map<string, PlutusData>([['123456', BigInt(1)]]),
          ],
        ]),
        [
          new Construct(0, [
            '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
            new Map<string, PlutusData>([
              ['', new Map<string, PlutusData>([['', BigInt(49000000)]])],
            ]),
          ]),
          new Construct(0, [
            '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
            new Map<string, PlutusData>([
              ['', new Map<string, PlutusData>([['', BigInt(1000000)]])],
            ]),
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
            new Map<string, PlutusData>([
              [
                'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
                new Map<string, PlutusData>([['123456', BigInt(1)]]),
              ],
            ]),
          ]),
        ],
      ]),
    ]),
  ]),
);

export const buyNoPaymentDatum: Data = Data.to(
  new Construct(1, [
    new Construct(0, []),
    new Construct(0, [
      new Construct(0, [
        '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
        new Map<string, PlutusData>([
          [
            'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
            new Map<string, PlutusData>([['123456', BigInt(1)]]),
          ],
        ]),
        [],
        BigInt(1648849688000),
        '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
      ]),
      new Construct(0, [
        '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
        [
          new Construct(0, [
            '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
            new Map<string, PlutusData>([
              [
                'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
                new Map<string, PlutusData>([['123456', BigInt(1)]]),
              ],
            ]),
          ]),
        ],
      ]),
    ]),
  ]),
);

export const buyRejectedDatum: Data = Data.to(
  new Construct(1, [
    new Construct(3, [
      '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
      '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
    ]),
    new Construct(0, [
      new Construct(0, [
        '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
        new Map<string, PlutusData>([
          [
            'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
            new Map<string, PlutusData>([['123456', BigInt(1)]]),
          ],
        ]),
        [
          new Construct(0, [
            '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
            new Map<string, PlutusData>([
              ['', new Map<string, PlutusData>([['', BigInt(49000000)]])],
            ]),
          ]),
          new Construct(0, [
            '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
            new Map<string, PlutusData>([
              ['', new Map<string, PlutusData>([['', BigInt(1000000)]])],
            ]),
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
            new Map<string, PlutusData>([
              [
                'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
                new Map<string, PlutusData>([['123456', BigInt(1)]]),
              ],
            ]),
          ]),
        ],
      ]),
    ]),
  ]),
);

export const offerDatum: Data = Data.to(
  new Construct(0, [
    new Construct(0, [
      '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
      new Map<string, PlutusData>([
        [
          'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
          new Map<string, PlutusData>([['123456', BigInt(1)]]),
        ],
      ]),
      [
        new Construct(0, [
          '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
          new Map<string, PlutusData>([
            ['', new Map<string, PlutusData>([['', BigInt(49000000)]])],
          ]),
        ]),
        new Construct(0, [
          '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
          new Map<string, PlutusData>([
            ['', new Map<string, PlutusData>([['', BigInt(1000000)]])],
          ]),
        ]),
      ],
      BigInt(1648849688000),
      '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
    ]),
  ]),
);

export const offerNoPayment: Data = Data.to(
  new Construct(0, [
    new Construct(0, [
      '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
      new Map<string, PlutusData>([
        [
          'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
          new Map<string, PlutusData>([['123456', BigInt(1)]]),
        ],
      ]),
      [],
      BigInt(1648849688000),
      '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
    ]),
  ]),
);

export const offerApprovedNoPaymentDatum: Data = Data.to(
  new Construct(1, [
    new Construct(1, [
      '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
    ]),
    new Construct(0, [
      new Construct(0, [
        '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
        new Map<string, PlutusData>([
          [
            'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
            new Map<string, PlutusData>([['123456', BigInt(1)]]),
          ],
        ]),
        [],
        BigInt(1648849688000),
        '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
      ]),
      new Construct(0, [
        '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
        [
          new Construct(0, [
            '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
            new Map<string, PlutusData>([
              [
                'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
                new Map<string, PlutusData>([['123456', BigInt(1)]]),
              ],
            ]),
          ]),
        ],
      ]),
    ]),
  ]),
);

export const sellerApprovedNoPaymentDatum: Data = Data.to(
  new Construct(1, [
    new Construct(1, [
      '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
    ]),
    new Construct(0, [
      new Construct(0, [
        '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
        new Map<string, PlutusData>([
          [
            'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
            new Map<string, PlutusData>([['123456', BigInt(1)]]),
          ],
        ]),
        [],
        BigInt(1648849688000),
        '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
      ]),
      new Construct(0, [
        '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
        [
          new Construct(0, [
            '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
            new Map<string, PlutusData>([
              [
                'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
                new Map<string, PlutusData>([['123456', BigInt(1)]]),
              ],
            ]),
          ]),
        ],
      ]),
    ]),
  ]),
);

export const sellerApprovedDatum: Data = Data.to(
  new Construct(1, [
    new Construct(1, [
      '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
    ]),
    new Construct(0, [
      new Construct(0, [
        '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
        new Map<string, PlutusData>([
          [
            'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
            new Map<string, PlutusData>([['123456', BigInt(1)]]),
          ],
        ]),
        [
          new Construct(0, [
            '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
            new Map<string, PlutusData>([
              ['', new Map<string, PlutusData>([['', BigInt(49000000)]])],
            ]),
          ]),
          new Construct(0, [
            '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
            new Map<string, PlutusData>([
              ['', new Map<string, PlutusData>([['', BigInt(1000000)]])],
            ]),
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
            new Map<string, PlutusData>([
              [
                'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
                new Map<string, PlutusData>([['123456', BigInt(1)]]),
              ],
            ]),
          ]),
        ],
      ]),
    ]),
  ]),
);

export const sellerRejectedDatum: Data = Data.to(
  new Construct(1, [
    new Construct(2, [
      '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
    ]),
    new Construct(0, [
      new Construct(0, [
        '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
        new Map<string, PlutusData>([
          [
            'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
            new Map<string, PlutusData>([['123456', BigInt(1)]]),
          ],
        ]),
        [
          new Construct(0, [
            '32de4124615eb739d59c5c733d1ccf1e0526ea87076770e0b7ba469a',
            new Map<string, PlutusData>([
              ['', new Map<string, PlutusData>([['', BigInt(49000000)]])],
            ]),
          ]),
          new Construct(0, [
            '02eae675ca7263105cef4afde685c21bbe80f23ea774b5a0b8834823',
            new Map<string, PlutusData>([
              ['', new Map<string, PlutusData>([['', BigInt(1000000)]])],
            ]),
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
            new Map<string, PlutusData>([
              [
                'd6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2',
                new Map<string, PlutusData>([['123456', BigInt(1)]]),
              ],
            ]),
          ]),
        ],
      ]),
    ]),
  ]),
);

export const cancelRedeemer: Data = Data.to(
  new Construct(2, [
    new Construct(0, [
      '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
      new Construct(0, []),
    ]),
  ]),
);

export const buyerApprovesRedeemer: Data = Data.to(
  new Construct(2, [
    new Construct(0, [
      '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
      new Construct(1, []),
    ]),
  ]),
);

export const mediatorApprovesRedeemer: Data = Data.to(
  new Construct(2, [
    new Construct(0, [
      '895ad7cdb46e6c251bc42724640dd68ff62dff291503ad18b6164e84',
      new Construct(1, []),
    ]),
  ]),
);
