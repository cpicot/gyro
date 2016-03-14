package fr.ganfra.realm;

import java.util.List;

import io.realm.RealmList;
import io.realm.RealmObject;

/* DO NOT EDIT | Generated by dbgenerator */

public class Animal extends RealmObject {

    public interface Attributes {
        String ATTRIBUTE = "attribute";
    }

    public interface Relationships {
        String RELATIONSHIP_NO_VALUE = "relationshipNoValue";
    }

    private String attribute;
    private List<String> relationshipNoValue;

    public String getAttribute() {
        return attribute;
    }

    public void setAttribute(final String attribute) {
        this.attribute = attribute;
    }

    public List<String> getRelationshipNoValue() {
        return relationshipNoValue;
    }

    public void setRelationshipNoValue(final List<String> relationshipNoValue) {
        this.relationshipNoValue = relationshipNoValue;
    }
}