//
//  Either.swift
//  EffectiveWaffle
//
//  Created by Ariel Rodriguez on 12/14/15.
//  Copyright © 2015 Ariel Rodriguez. All rights reserved.
//

import Foundation

public enum Either<T1,T2> {
    case Left(T1)
    case Right(T2)
}