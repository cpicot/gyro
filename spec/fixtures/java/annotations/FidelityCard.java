package com.gyro.tests;

/* DO NOT EDIT | Generated by gyro */

import io.realm.RealmObject;
import io.realm.annotations.Required;

public class FidelityCard extends RealmObject {

    public static final class Attributes {
        public static final String IDENTIFIER = "identifier";
        public static final String POINTS = "points";

        private Attributes() {
            // Hide constructor
        }
    }

    public static final class Relationships {
        public static final String USER = "user";

        private Relationships() {
            // Hide constructor
        }
    }

    private short identifier;
    @android.support.annotation.IntRange(from=0,to=255)
    private int points = 0;
    private User user;

    public short getIdentifier() {
        return identifier;
    }

    public void setIdentifier(final short identifier) {
        this.identifier = identifier;
    }

    @android.support.annotation.IntRange(from=0,to=255)
    public int getPoints() {
        return points;
    }

    public void setPoints(@android.support.annotation.IntRange(from=0,to=255) final int points) {
        this.points = points;
    }

    @android.support.annotation.NonNull
    public User getUser() {
        return user;
    }

    public void setUser(@android.support.annotation.NonNull final User user) {
        this.user = user;
    }
}
