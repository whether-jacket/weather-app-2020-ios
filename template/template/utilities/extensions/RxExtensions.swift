import Foundation
import RxSwift

extension Observable {

    func subscribeOnIo() -> Observable {
        return subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
    }
    
    func subscribeOnMain() -> Observable {
        return subscribeOn(MainScheduler.instance)
    }
    
    func observeOnIo() -> Observable {
        return observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
    }
    
    func observeOnMain() -> Observable {
        return observeOn(MainScheduler.instance)
    }
}


extension Single {
    
    func subscribeOnIo<T>() -> Single<T> where T : Any {
        return subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)) as! PrimitiveSequence<SingleTrait, T>
    }
    
    func subscribeOnMain<T>() -> Single<T> where T : Any {
        return subscribeOn(MainScheduler.instance) as! PrimitiveSequence<SingleTrait, T>
    }
    
    func observeOnIo<T>() -> Single<T> where T : Any {
        return observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)) as! PrimitiveSequence<SingleTrait, T>
    }
    
    func observeOnMain<T>() -> Single<T> where T : Any {
        return observeOn(MainScheduler.instance) as! PrimitiveSequence<SingleTrait, T>
    }
}


extension Completable {
    
    func subscribeOnIo() -> Completable {
        return subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
    }
    
    func subscribeOnMain() -> Completable {
        return subscribeOn(MainScheduler.instance)
    }
    
    func observeOnIo() -> Completable {
        return observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
    }
    
    func observeOnMain() -> Completable {
        return observeOn(MainScheduler.instance)
    }
}
