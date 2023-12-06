
#include "rwlock.h"

#define NUM_COUNTERS 16

//init the lock
// called by the thread running the benchmark before any child threads are spawned.
void rw_lock_init(struct ReaderWriterLock *rwlock) {
  rwlock->readers = 0;
  rwlock->writer = 0;
}

/**
 * Try to acquire a lock and spin until the lock is available.
 * Readers should add themselves to the read counter,
 * then check if a writer is waiting
 * If a writer is waiting, decrement the counter and wait for the writer to finish
 * then retry
 */
void read_lock(struct ReaderWriterLock *rwlock, uint8 thread_id) {
  //acq read lock
  while (1){

    //atomic_add_fetch returns current value, but not needed
    __atomic_add_fetch(&rwlock->readers, 1, __ATOMIC_SEQ_CST);


    if (rwlock->writer){
      //cancel
      __atomic_add_fetch(&rwlock->readers, -1, __ATOMIC_SEQ_CST);
      //wait
      while (rwlock->writer);      
    } else {
      return;
    }
  }
}

//release an acquired read lock for thread `thread_id`
void read_unlock(struct ReaderWriterLock *rwlock, uint8 thread_id) {
  __atomic_add_fetch(&rwlock->readers, -1, __ATOMIC_SEQ_CST);
  return;
}

/**
 * Try to acquire a write lock and spin until the lock is available.
 * Spin on the writer mutex.
 * Once it is acquired, wait for the number of readers to drop to 0.
 */
void write_lock(struct ReaderWriterLock *rwlock) {
  // acquire write lock.
  while (__sync_lock_test_and_set(&rwlock->writer, 1))
    while (rwlock->writer != 0)
      ;
  //once acquired, wait on readers
  while (rwlock->readers > 0);
  return;
}

//Release an acquired write lock.
void write_unlock(struct ReaderWriterLock *rwlock) {
  __sync_lock_release(&rwlock->writer);
  return;
}
