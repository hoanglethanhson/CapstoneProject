import Firebase from 'firebase-admin';
import FirebaseApp from './firebaseApp';

export default class DBFirebase {
    static pushNotification = async ({receiverId, notificationId, content}) => {
        const ref = FirebaseApp.database().ref(`/users/${receiverId}/notification`);
        const key = ref.push().key;
        await ref.update({
            [key]: {
                ...content,
                read: false,
                id: notificationId,
                type: 'notification',
                receiver: {id: receiverId},
                timestamp: Firebase.database.ServerValue.TIMESTAMP,
                description: {type: 'TEXT', content: content.description},
            }
        });
    };
}
