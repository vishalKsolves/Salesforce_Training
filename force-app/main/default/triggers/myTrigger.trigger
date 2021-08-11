trigger myTrigger on Account (before insert) {
    System.debug('Hello World!');
}